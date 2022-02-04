import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:multisuperstore/src/elements/ButtonShimmerWidget.dart';
import 'package:multisuperstore/src/elements/ControllPanelWidget.dart';
import 'package:multisuperstore/src/elements/CustomAppBar.dart';
import 'package:multisuperstore/src/elements/HandyManCard.dart';
import 'package:multisuperstore/src/elements/MyRecommendedTypeWidge.dart';
import 'package:multisuperstore/src/elements/RectangularLoaderWidget.dart';
import 'package:multisuperstore/src/elements/SearchBarWidget.dart';
import 'package:multisuperstore/src/elements/SearchWidgetShop.dart';
import 'package:multisuperstore/src/elements/Spotlight.dart';
import 'package:multisuperstore/src/elements/VendorDetailsPopup.dart';
import 'package:multisuperstore/src/models/main_category.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';
import 'package:shimmer/shimmer.dart';
import '../elements/CategoryLoaderWidget.dart';
import '../elements/MiddleSliderWidget.dart';

import '../elements/CategoryshopType.dart';
import '../elements/ShopTypesSlider.dart';
import '../elements/LocationWidget.dart';
import '../controllers/home_controller.dart';
import '../elements/HomeSliderWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.iconColor, this.labelColor, this.parentScaffoldKey})
      : super(key: key);
  final Color iconColor;
  final Color labelColor;
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  HomeController _con;
  bool loader = false;
  String qrCodeResult = "Not Yet Scanned";

  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (currentUser.value.recommendation != 'load') {
      _con.listenForMyRecommendation();
    }

    _con.listenForVendor();
    _con.listenForShopCategories();
    _con.listenForSlides(1);
    _con.listenForMiddleSlides(2);
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (barcodeScanRes != '-1') {
      setState(() {
        qrCodeResult = barcodeScanRes;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return VendorFullDetailsPopWidget(
              shopId: qrCodeResult,
            );
          });
    }
  }

// ignore: non_constant_identifier_names

  void controlPanel() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.92,
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
                      Expanded(
                          child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ControlPanel(),
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Container(
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: CustomAppBar(
              parentScaffoldKey: widget.parentScaffoldKey,
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
                  Stack(children: [
                    Container(
                      // Here the height of the container is 45% of our total height
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    HomeSliderWidget(slides: _con.slides),
                  ]),
                  // StopTypeWidget(TypeDate: _con.shopTypeList),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).my_Recommended.toUpperCase(),
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.orange[900],
                                fontFamily: 'Futura-Book-Bold',
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('ogni cosa che puoi desiderare la trovi qui!',
                              style: TextStyle(
                                  fontFamily: 'Futura-Book-Bold',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ]),
                  ),
                  SizedBox(height: 5),
                  currentRecommendation.value.isEmpty
                      ? CategoryLoaderWidget()
                      : MyRecommendedTypeWidge(
                          shopType: currentRecommendation.value,
                        ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LASCIATI ISPIRARE",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.orange[900],
                                fontSize: 19,
                                fontFamily: 'Futura-Book-Bold',
                                fontWeight: FontWeight.bold),
                          ),
                          Text('i nostri suggerimenti',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Futura-Book-Bold',
                              )),
                        ]),
                  ),
                  SizedBox(height: 15),

                  // _con.mainShopCategories.isEmpty
                  //     ? ButtonShimmerWidget()
                  //     : Container(
                  //         height: 67,
                  //         child: ListView.builder(
                  //             scrollDirection: Axis.horizontal,
                  //             itemCount: _con.mainShopCategories.length,
                  //             padding: EdgeInsets.only(right: 10),
                  //             itemBuilder: (context, index) {
                  //               MainCategoryModel _category =
                  //                   _con.mainShopCategories.elementAt(index);

                  //               return Container(
                  //                   padding: EdgeInsets.only(
                  //                     top: 15,
                  //                     bottom: 12,
                  //                     left: 12,
                  //                   ),
                  //                   child: InkWell(
                  //                     onTap: () {
                  //                       _con.mainShopCategories.forEach((_l) {
                  //                         setState(() {
                  //                           _l.selected = false;
                  //                         });
                  //                       });
                  //                       _category.selected = true;
                  //                       _con.listenForDealOfDay(_category.id);
                  //                     },
                  //                     child: Container(
                  //                         padding: EdgeInsets.only(
                  //                             top: 5,
                  //                             left: 13,
                  //                             right: 13,
                  //                             bottom: 5),
                  //                         decoration: BoxDecoration(
                  //                           color: _category.selected
                  //                               ? Theme.of(context)
                  //                                   .colorScheme
                  //                                   .secondary
                  //                               : Theme.of(context)
                  //                                   .primaryColor,
                  //                           boxShadow: [
                  //                             BoxShadow(
                  //                               color: Colors.black12
                  //                                   .withOpacity(0.2),
                  //                               blurRadius:
                  //                                   _category.selected ? 3 : 1,
                  //                               spreadRadius: _category.selected
                  //                                   ? 3
                  //                                   : 0.3,
                  //                             ),
                  //                           ],
                  //                           borderRadius:
                  //                               BorderRadius.circular(20),
                  //                         ),
                  //                         child: Center(
                  //                           child: Container(
                  //                               child: Wrap(children: [
                  //                             Icon(Icons.ac_unit_sharp,
                  //                                 color: _category.selected
                  //                                     ? Colors.white
                  //                                     : Theme.of(context)
                  //                                         .hintColor),
                  //                             Container(
                  //                                 padding: EdgeInsets.only(
                  //                                     top: 3,
                  //                                     left: 10,
                  //                                     right: 5),
                  //                                 child: Text(_category.name,
                  //                                     textAlign:
                  //                                         TextAlign.center,
                  //                                     style: TextStyle(
                  //                                         fontFamily:
                  //                                             'Futura-Book-Regular',
                  //                                         fontWeight:
                  //                                             FontWeight.w100,
                  //                                         color: _category
                  //                                                 .selected
                  //                                             ? Colors.white
                  //                                             : Theme.of(
                  //                                                     context)
                  //                                                 .hintColor))),
                  //                           ])),
                  //                         )),
                  //                   ));
                  //             }),
                  //       ),

                  _con.shopTypeList.isEmpty
                      ? CategoryLoaderWidget()
                      : CategoryShopType(
                          shopType: _con.shopTypeList,
                        ),

                  // ListTile(
                  //   dense: true,
                  //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //   title: Text(
                  //     S.of(context).nearest_shop,
                  //     style: Theme.of(context).textTheme.headline3,
                  //   ),
                  //   subtitle: Text(
                  //     'Nearest for you',
                  //     maxLines: 2,
                  //     style: Theme.of(context).textTheme.caption,
                  //   ),
                  // ),

                  // ShopTopSlider(
                  //   vendorList: _con.vendorList,
                  //   key: null,
                  // ),
                  SizedBox(height: 20),
                  //  MiddleSliderWidget(slides: _con.middleSlides),
                  SizedBox(height: 15),
                ]),
              ),
              // SliverAppBar(
              //   pinned: true,
              //   primary: false,
              //   snap: false,
              //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              //   floating: false,
              //   automaticallyImplyLeading: false,
              //   title: Text('Best Recommended Shop',
              //       style: Theme.of(context).textTheme.headline3),
              //   titleSpacing: 20,
              //   bottom: TabBar(
              //     isScrollable: true,
              //     unselectedLabelColor: Theme.of(context).disabledColor,
              //     tabs: [
              //       Tab(text: "Best Rated"),
              //       /**  Tab(text: "Recent View"),
              //               Tab(text: "Trending"),
              //               Tab(text: "Popular Items"),
              //                **/
              //     ],
              //   ),
              // ),
              // new SliverFillRemaining(
              //   fillOverscroll: false,
              //   child: TabBarView(
              //     children: <Widget>[
              //       currentRecommendation.value.isEmpty
              //           ? RectangularLoaderWidget()
              //           : Container(
              //               child: SpotlightWidget(),
              //             ),
              //     ],
              //   ),
              // ),
            ])),
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
                              _con.listenForVendor();
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
