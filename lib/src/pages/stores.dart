import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/CategoryLoaderWidget.dart';
import 'package:multisuperstore/src/elements/CategoryshopType.dart';
import 'package:multisuperstore/src/elements/CustomAppBar.dart';
import 'package:multisuperstore/src/elements/DrawerWidget.dart';
import 'package:multisuperstore/src/elements/LocationWidget.dart';
import 'package:multisuperstore/src/elements/MyRecommendedTypeWidge.dart';
import 'package:multisuperstore/src/elements/SearchBarWidget.dart';
import 'package:multisuperstore/src/elements/SearchWidgetShop.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../elements/ShopListBoxWidget.dart';
import '../controllers/vendor_controller.dart';
import '../Widget/custom_divider_view.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';


// ignore: must_be_immutable
class Stores extends StatefulWidget {
   int storeType;
   String pageTitle;
   int focusId;
   String coverImage;
   String previewImage;
   Stores({Key key, this.storeType,this.pageTitle,this.focusId, this.coverImage, this.previewImage})
       : super(key: key);
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends StateMVC<Stores> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  VendorController _con;

  _StoresState() : super(VendorController()) {
    _con = controller;
  }
  @override
  void initState() {
    // TODO: implement initState
    _con.listenForVendorList(widget.storeType, widget.focusId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar(
        parentScaffoldKey: scaffoldKey,
        showModal: showModal,
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate(<Widget>[
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                          child: Text(
                            widget.pageTitle,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                fontSize: 16),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 1,
                        width: MediaQuery.of(context).size.width/3,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 15),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).stores_near_by,
                              style: Theme.of(context).textTheme.caption.merge(TextStyle(
                                color: Colors.black,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: MediaQuery.of(context).size.width/2.5,
                width: double.infinity,
                decoration: new BoxDecoration(
                  border: Border.all(color: Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                Image.network(
                  widget.coverImage,
                  height: MediaQuery.of(context).size.width/2.5,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              ShopListBoxWidget(con: _con,
                pageTitle: widget.pageTitle,
                shopType: widget.storeType,
                focusId: widget.focusId,
                previewImage: widget.previewImage, key: null,),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TORNA ALLE CATEGORIE",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange[900],
                            fontSize: 19,
                            fontFamily: 'Futura-Book-Bold',
                            fontWeight: FontWeight.bold),
                      ),
                      Text('ogni cosa che puoi desiderare la travi  qui!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Futura-Book-Bold',
                          )),
                    ]),
              ),
              SizedBox(height: 15),
              currentRecommendation.value.isEmpty
                  ? CategoryLoaderWidget()
                  : MyRecommendedTypeWidge(
                shopType: currentRecommendation.value,
              ),
              // _con.shopTypeList.isEmpty
              //     ? CategoryLoaderWidget()
              //     : CategoryShopType(
              //   shopType: _con.shopTypeList,
              // ),
              SizedBox(height: 25),
            ]
            )
        )])
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

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final int shopType;
  final String coverImage;
  final String pageTitle;

  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.shopType,
    this.pageTitle,
    this.coverImage,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 300).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            coverImage,
            height: MediaQuery.of(context).size.height / 0.5,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),

          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  padding: EdgeInsets.only(top: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 10, right: 10, top: 25),
                                child: Text(
                                  pageTitle,
                                  style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                                      )),
                                )),
                          ],
                        ),
                        CustomDividerView(
                          dividerHeight: 1.0,
                          color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    S.of(context).stores_near_by,
                                    style: Theme.of(context).textTheme.caption.merge(TextStyle(
                                          color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                                        )),
                                  ),
                                ),
                             /**   Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Icon(
                                    Icons.filter_list,
                                    size: 19,
                                    color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'SORT/FILTER',
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(
                                        color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                                      )),
                                ), */
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



