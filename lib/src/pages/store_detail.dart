import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/CustomAppBar.dart';
import 'package:multisuperstore/src/elements/DeliveryModeWidget.dart';
import 'package:multisuperstore/src/elements/DrawerWidget.dart';
import 'package:multisuperstore/src/elements/LocationWidget.dart';
import 'package:multisuperstore/src/elements/OfferDetailsWidget.dart';
import 'package:multisuperstore/src/elements/RectangularLoaderWidget.dart';
import 'package:multisuperstore/src/elements/SearchBarWidget.dart';
import 'package:multisuperstore/src/elements/SearchWidgetRe.dart';
import 'package:multisuperstore/src/elements/SearchWidgetShop.dart';
import 'package:multisuperstore/src/elements/VendorDetailsPopup.dart';
import 'package:multisuperstore/src/repository/order_repository.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:multisuperstore/src/repository/vendor_repository.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/vendor_controller.dart';
import '../elements/BottomBarWidget.dart';
import '../elements/Productbox1Widget.dart';
import '../models/restaurant_product.dart';
import '../models/vendor.dart';
import 'chat_detail_page.dart';

// ignore: must_be_immutable
class StoreViewDetails extends StatefulWidget {
  Vendor shopDetails;
  int shopTypeID;
  int focusId;
  StoreViewDetails({Key key, this.shopDetails, this.shopTypeID, this.focusId})
      : super(key: key);
  @override
  _StoreViewDetailsState createState() => _StoreViewDetailsState();
}

class _StoreViewDetailsState extends StateMVC<StoreViewDetails>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  VendorController _con;

  _StoreViewDetailsState() : super(VendorController()) {
    _con = controller;
  }

  final controller1 = ScrollController();
  double itemsCount = 25;
  // ignore: non_constant_identifier_names
  double AdBlockHeight = 130.0;
  double itemHeight = 130.0;
  double screenWidth = 0.0;
  double calculateSize = 0.0;
  double shopTitle = 10.0;
  double subOpacity = 1.0;
  bool popperShow = false;
  @override
  void initState() {
    super.initState();
    controller1.addListener(onScroll);
    _con.listenForRestaurantProduct(int.parse(widget.shopDetails.shopId));
    //   _tabController = TabController(vsync: this, length: );
    currentVendor.value = widget.shopDetails;

    if (currentCheckout.value.deliverType == null) {
      currentCheckout.value.deliverType = 1;
    }
  }

  tabMaker() {
    // ignore: deprecated_member_use
    List<Tab> tabs = List();

    _con.vendorResProductList.forEach((element) {
      tabs.add(Tab(
        text: element.category_name.toUpperCase(),
      ));
    });
    return tabs;
  }

  onScroll() {
    setState(() {
      calculateSize = itemHeight - controller1.offset;

      if (calculateSize > 65) {
        AdBlockHeight = calculateSize;
        shopTitle = controller1.offset;
        subOpacity = 0;
      }
      if (shopTitle < 10) {
        shopTitle = 10;
        subOpacity = 1.0;
      }
      //print(cWidth);
      //loginWidth = 250.0;
    });
  }

  void callback(bool nextPage) {
    setState(() {
      this.popperShow = nextPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.vendorResProductList.length,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BottomBarWidget(),
        key: scaffoldKey,
        drawer: DrawerWidget(),
        backgroundColor: Theme.of(context).primaryColor,
        appBar: CustomAppBar(
          parentScaffoldKey: scaffoldKey,
          showModal: showModal,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: []),
                Expanded(
                  child: SearchBarWidget(
                    onClickFilter: (event) {},
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SearchResultWidgetShop();
                        }));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        //    color: Color(0xFFaeaeae).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4)),
                      child: Icon(
                        Icons.mic,
                        color: Theme.of(context).hintColor,
                        size: 40,
                      )),
                ),
              ]),
            ),

            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Stack(
                            children:[
                              Container(
                                decoration: new BoxDecoration(
                                  border: Border.all(color: Colors.transparent, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:
                                ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.transparent, // 0 = Colored, 1 = Black & White
                                    BlendMode.saturation,
                                  ),
                                  child:ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: widget.shopDetails.logo!='no_image'?CachedNetworkImage(
                                        imageUrl: widget.shopDetails.logo,
                                        placeholder: (context, url) => new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => new Icon(Icons.error),
                                        fit: BoxFit.cover,
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        height: MediaQuery.of(context).size.width * 0.2,
                                      ):CachedNetworkImage(
                                        imageUrl: widget.shopDetails.logo,
                                        placeholder: (context, url) => new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => new Icon(Icons.error),
                                        fit: BoxFit.cover,
                                        width: MediaQuery.of(context).size.width * 0.24,
                                        height: MediaQuery.of(context).size.width * 0.24,
                                      )),
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(
                                widget.shopDetails.shopName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 24),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 0),
                                    height: 1,
                                    width: MediaQuery.of(context).size.width/3,
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0, right: 15),
                                child:
                                Text(widget.shopDetails.subtitle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,

                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0, right: 15),
                                child: Text(widget.shopDetails.locationMark.replaceAll(',', '|'),
                                  overflow: TextOverflow.ellipsis, maxLines: 1,

                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12),),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Wrap(children: [
                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Text(Helper.priceDistance(widget.shopDetails.distance), style: Theme.of(context).textTheme.bodyText2),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0, left: 15),
                                  child: Icon(Icons.star, color: Colors.orange[500], size: 15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text('${widget.shopDetails.rate}     ', style: Theme.of(context).textTheme.bodyText2),
                                ),

                                // Padding(
                                //   padding: const EdgeInsets.only(left: 3),
                                //   child: Text('     ${Helper.calculateTime(double.parse(choice.distance.replaceAll(',','')))}', style: Theme.of(context).textTheme.bodyText2),
                                // ),
                              ]),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),

            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 0, right: 0),
                  height: 1,
                  width: MediaQuery.of(context).size.width/1.2,
                  color: Colors.orange,
                ),
              ],
            ),

            SizedBox(height: 15,),

            Expanded(
              child: NestedScrollView(
                controller: controller1,
                headerSliverBuilder: (BuildContext context, bool isScrolled) {
                  return [
                    SliverPersistentHeader(
                      floating: false,
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          indicatorWeight: 2.0,
                          isScrollable: true,
                          indicatorColor: Colors.red,
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.white,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                            color: Colors.transparent,
                          ),
                          tabs: tabMaker(),
                        ),
                      ),
                    ),
                  ];
                },
                body: _con.vendorResProductList.isEmpty
                    ? RectangularLoaderWidget()
                    : TabBarView(
                  children: List.generate(
                    _con.vendorResProductList.length,
                        (index) {
                      RestaurantProduct _productDetails =
                      _con.vendorResProductList.elementAt(index);
                      return ProductBox1Widget(
                        productData: _productDetails.productdetails,
                        shopId: widget.shopDetails.shopId,
                        shopName: widget.shopDetails.shopName,
                        subtitle: widget.shopDetails.subtitle,
                        km: widget.shopDetails.distance,
                        shopTypeID: widget.shopTypeID,
                        latitude: widget.shopDetails.latitude,
                        longitude: widget.shopDetails.longitude,
                        callback: this.callback,
                        focusId: widget.focusId,
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }


  void showModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            color: Color(0xff737373),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              LocationModalPart(),
                            ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Container(
                        width: double.infinity,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            onPressed: () {
                              setState(() => currentUser.value);
                              Navigator.pop(context);
                              // _con.listenForVendor();
                            },
                            padding: EdgeInsets.all(15),
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(1),
                            child: Text(
                              S.of(context).proceed_and_close,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(color: Colors.white)),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class TransitionAppBar extends StatefulWidget {
  final Widget avatar;
  final Widget title;
  final double extent;
  final double height;
  final double shopTitle;
  final Vendor shopDetails;
  final double subOpacity;
  final int shopTypeID;
  final int focusId;
  final Function callback;
  final List<RestaurantProduct> itemDetails;
  TransitionAppBar(
      {this.avatar,
      this.title,
      this.extent = 250,
      this.height,
      this.shopTitle,
      this.shopDetails,
      this.subOpacity,
      this.shopTypeID,
      this.focusId,
      this.itemDetails,
      this.callback,
      Key key})
      : super(key: key);

  @override
  _TransitionAppBarState createState() => _TransitionAppBarState();
}

class _TransitionAppBarState extends State<TransitionAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
          shopTypeID: widget.shopTypeID,
          avatar: widget.avatar,
          title: widget.title,
          extent: widget.extent > 200 ? widget.extent : 91,
          height: widget.height,
          shopTitle: widget.shopTitle,
          shopDetails: widget.shopDetails,
          itemDetails: widget.itemDetails,
          callback: widget.callback,
          focusId: widget.focusId,
          subOpacity: widget.subOpacity,
          scrollController: null),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 40, bottom: 70, left: 30),
      end: EdgeInsets.only(
        left: 30,
        top: 30.0,
        bottom: 10,
      ));
  final _avatarAlignTween =
      AlignmentTween(begin: Alignment.topLeft, end: Alignment.bottomLeft);
  final double heights;
  final Widget avatar;
  final Widget title;
  final double extent;
  final double height;
  final double shopTitle;
  final Vendor shopDetails;
  final double subOpacity;
  final int shopTypeID;
  final Function callback;
  final int focusId;
  final List<RestaurantProduct> itemDetails;
  _TransitionAppBarDelegate({
    this.avatar,
    this.heights,
    this.title,
    this.extent = 250,
    this.height,
    this.shopTitle,
    this.shopDetails,
    this.subOpacity,
    this.shopTypeID,
    this.itemDetails,
    this.focusId,
    this.callback,
    @required ScrollController scrollController,
  })  : assert(avatar != null),
        assert(extent == null || extent >= 200),
        assert(title != null);

  void offerDetail(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: Color(0xff737373),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.grey[200],
                          width: 1,
                        ))),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                S.of(context).offer_details,
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.left,
                              ),
                            )),
                      ),
                      Expanded(
                          child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              OfferDetailsPart(
                                pageType: 'vendor',
                                shopId: shopDetails.shopId,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )),
                    ],
                  )),
            ),
          );
        });
  }

  deliveryMode(context, shopDetails) {
    Future<void> future = showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: Color(0xff737373),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border(
                                bottom: BorderSide(
                              color: Colors.grey[200],
                              width: 1,
                            ))),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                S.of(context).pick_your_preference,
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.left,
                              ),
                            )),
                      ),
                      Expanded(
                          child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DeliveryMode(
                                shopDetails: shopDetails,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )),
                    ],
                  )),
            ),
          );
        });
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 34 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;

    final avatarMargin = _avatarMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);

    return Stack(
      children: <Widget>[
        Image(
            image: shopDetails.cover == 'no_image' && shopTypeID == 2
                ? AssetImage(
                    'assets/img/resturentdefaultbg.jpg',
                  )
                : NetworkImage(shopDetails.cover),
            height: 190,
            width: double.infinity,
            fit: BoxFit.cover),
        Padding(
          padding: EdgeInsets.only(top: 40, right: 20),
          child: Align(
              alignment: Alignment.topRight,
              child: Wrap(children: [
                Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                    child: IconButton(
                      icon: new Icon(Icons.chat,
                          color: Theme.of(context).primaryColorLight, size: 18),
                      onPressed: () {
                        if (currentUser.value.apiToken != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatDetailPage(
                                  shopId: shopDetails.shopId,
                                  shopName: shopDetails.shopName,
                                  shopMobile: '1')));
                        } else {
                          Navigator.of(context).pushNamed('/Login');
                        }
                      },
                    )),
                SizedBox(width: 20),
                Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                    child: IconButton(
                      icon:
                          new Icon(Icons.close, color: Colors.black, size: 16),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
              ])),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Stack(clipBehavior: Clip.none, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedContainer(
                color: Colors.transparent,
                duration: Duration(seconds: 0),
                height: height,
                width: double.infinity,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 10.0,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: shopTitle, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(shopDetails.shopName,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                ],
                              ),
                            ),
                            Wrap(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return VendorFullDetailsPopWidget(
                                            shopId: shopDetails.shopId,
                                          );
                                        });
                                  },
                                  child: Icon(Icons.help_outline),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 17,
                                ),
                                SizedBox(width: 2),
                                Text(shopDetails.rate,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                              ],
                            )
                          ]),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: subOpacity == 1.0
                                ? Text(
                                    shopDetails.subtitle,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  )
                                : Text('')),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 8, left: 10, right: 10, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          deliveryMode(context, shopDetails);
                                          //setState(() => currentUser.value);
                                        },
                                        child: Row(children: [
                                          currentCheckout.value.deliverType == 1
                                              ? Icon(Icons.delivery_dining)
                                              : currentCheckout
                                                          .value.deliverType ==
                                                      2
                                                  ? Icon(Icons.lock_clock)
                                                  : Icon(Icons.takeout_dining),
                                          SizedBox(width: 5),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(children: [
                                                  Text(
                                                      Helper.priceDistance(
                                                          shopDetails.distance),
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                      )),
                                                  SizedBox(width: 2),
                                                  Icon(Icons.arrow_drop_down,
                                                      size: 15),
                                                ]),
                                                Text(S.of(context).distance,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ])
                                        ]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Row(children: [
                                        Icon(Icons.access_time, size: 15),
                                        SizedBox(width: 5),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${Helper.calculateTime(double.parse(shopDetails.distance.replaceAll(',', '')))}',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  )),
                                              Text(
                                                S.of(context).delivery_time,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ])
                                      ]),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  /**  Column(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  offerDetail(context);
                                                },
                                                child: Row(
                                                    children:[
                                                      Icon(Icons.local_offer_outlined,size:15),
                                                      SizedBox(width:5),
                                                      Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children:[
                                                            Wrap(
                                                                children:[


                                                                  Text(S.of(context).offer,
                                                                      style: TextStyle(fontSize:10,color:Colors.black.withOpacity(0.6))
                                                                  ),


                                                                  SizedBox(width:2),
                                                                  Icon(Icons.arrow_drop_down,size:15)
                                                                ]
                                                            ),


                                                          ]
                                                      )
                                                    ]
                                                ),
                                              ),

                                            ],
                                          ), 
                                          **/
                                ]),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          SearchResultWidgetRe(
                                            itemDetails: itemDetails,
                                            shopId: shopDetails.shopId,
                                            shopName: shopDetails.shopName,
                                            subtitle: shopDetails.subtitle,
                                            km: shopDetails.distance,
                                            shopTypeID: shopTypeID,
                                            latitude: shopDetails.latitude,
                                            longitude: shopDetails.longitude,
                                            callback: this.callback,
                                            focusId: focusId,
                                          )));
                                },
                                icon: Icon(Icons.search),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: -30,
                left: 30,
                child: Shimmer(
                    duration: Duration(seconds: 3),
                    // This is NOT the default value. Default value: Duration(seconds: 0)
                    interval: Duration(seconds: 0),
                    // This is the default value
                    color: Colors.white,
                    // This is the default value
                    colorOpacity: 0.5,
                    // This is the default value
                    enabled: true,
                    // This is the default value
                    direction: ShimmerDirection.fromLTRB(),
                    child: Stack(children: [
                      Container(
                          width: 80,
                          height: 70,
                          child: Image(
                              image: AssetImage('assets/img/sellerlable.png'))),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            margin: EdgeInsets.only(top: 28, left: 5),
                            alignment: Alignment.center,
                            child: Center(
                                child: Text(
                              S.of(context).best_seller,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ))),
                      )
                    ])))
          ]),
        ),
        Padding(
          padding: avatarMargin,
          child: Align(
              alignment: avatarAlign,
              child: Hero(tag: shopDetails.shopId, child: avatar)),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: title,
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => (maxExtent * 68) / 100;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height*0.6;

  @override
  double get maxExtent => _tabBar.preferredSize.height*0.6;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      margin: EdgeInsets.only(top: 0, left: 15, right: 15),
      decoration: new BoxDecoration(
          color: Color.fromRGBO(0xF5, 0x84, 0x31, 1.0),
          borderRadius: new BorderRadius.circular(4)
      ),
      child: Container(
        margin: EdgeInsets.only(top: 0, left: 0, right: 0),
        color: Color.fromRGBO(0xF5, 0x84, 0x31, 0),
        child: _tabBar,
      )
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
