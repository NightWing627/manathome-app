import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:multisuperstore/src/helpers/string_helper.dart';
import 'package:multisuperstore/src/repository/vendor_repository.dart';
import '../repository/product_repository.dart';
import '../helpers/helper.dart';
import '../repository/order_repository.dart';
import '../controllers/cart_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../elements/CheckoutListWidget.dart';
import '../repository/product_repository.dart' as cartRepo;
import '../../generated/l10n.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends StateMVC<CheckoutPage> {
  bool popperShow = false;
  CartController _con;
  _CheckoutPageState() : super(CartController()) {
    _con = controller;
  }
  void callback(bool nextPage) {
    setState(() {
      this.popperShow = nextPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: popperShow
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: FlareActor(
                      'assets/img/winners.flr',
                      animation: 'boom',
                    )),
              )
            : Container(),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 6,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ValueListenableBuilder(
                  valueListenable: cartRepo.currentCart,
                  builder: (context, _setting, _) {
                    return Column(children: [
                      currentCheckout.value.deliveryPossible
                          ? Container()
                          : Container(
                              child: SingleChildScrollView(
                                  child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.2,
                                        right: size.width * 0.2,
                                        top: 10),
                                    child: Container(
                                      width: double.infinity,
                                      // ignore: deprecated_member_use
                                      child: FlatButton(
                                        onPressed: () {
                                          /*Navigator.of(context).pushNamed('/Login');*/
                                        },
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        color: Colors.blueGrey.shade900,
                                        child: Column(
                                          children: [
                                            Text(
                                              S.of(context).change_address,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .merge(TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColorLight,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                                S
                                                    .of(context)
                                                    .use_another_address,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Theme.of(context)
                                                      .primaryColorLight
                                                      .withOpacity(0.7),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                      currentCheckout.value.deliveryPossible
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 40),
                                      alignment: Alignment.bottomCenter,
                                      child: Wrap(
                                          alignment: WrapAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5,
                                                          right: 10,
                                                          left: 20,
                                                          bottom: 10),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            ' ${Helper.pricePrint(currentCheckout.value.grand_total)}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1),
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .view_bill_details,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _con.gotopayment();
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8,
                                                          right: 5,
                                                          left: 5,
                                                          bottom: 8),
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .proceed_to_pay,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .merge(TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ])),
                                ])
                          : Text(''),
                    ]);
                  })
            ],
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              ValueListenableBuilder(
                  valueListenable: cartRepo.currentCart,
                  builder: (context, _setting, _) {
                    // _con.grandSummary();
                    return SliverPersistentHeader(
                      pinned: true,
                      floating: false,
                      delegate: SliverCustomHeaderDelegate(
                        title: currentCheckout.value.shopName,
                        collapsedHeight: 70,
                        expandedHeight: 120,
                        paddingTop: MediaQuery.of(context).padding.top,
                        coverImgUrl:
                            'http://www.sriaghraharamatrimoni.com/assets/new_home_page/images/lp-3.png',
                        subtitle:
                            '${currentCart.value.length} ${S.of(context).items}, to pay  ${Helper.pricePrint(currentCheckout.value.grand_total)}',
                      ),
                    );
                  }),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  CheckoutListWidget(
                    con: _con,
                    callback: this.callback,
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  final String subtitle;
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
    this.subtitle,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  void updateStatusBarBrightness(shrinkOffset) {
    if (shrinkOffset > 50 && this.statusBarMode == 'dark') {
      this.statusBarMode = 'light';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ));
    } else if (shrinkOffset <= 50 && this.statusBarMode == 'light') {
      this.statusBarMode = 'dark';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  List<String> subtitleHeaderList = currentVendor.value.locationMark != null
      ? currentVendor.value.locationMark.split(',')
      : '';
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    this.updateStatusBarBrightness(shrinkOffset);
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(Icons.arrow_back_ios),
                // ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 100,
                      color: Colors.red,
                      height: 100,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        // ignore: deprecated_member_use
                        imageUrl:
                            "${GlobalConfiguration().getString('base_upload')}/uploads/vendor_image/vendor_${currentCheckout.value.shopId}.png",
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Expanded(
                      child: Container(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(currentCheckout.value.shopName.toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.orange[900],
                              fontFamily: 'Futura-Book-Bold',
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      Text(
                        currentCheckout.value.subtitle.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Futura-Book-Bold',
                            fontSize: 14,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Text(
                          titleize(subtitleHeaderList[0]) +
                              ' | ' +
                              titleize(
                                  subtitleHeaderList[1].replaceFirst(' ', '')),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Futura-Book-Bold',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ))),
                )
              ],
            ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: this
                              .makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.title,
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .merge(TextStyle(
                                  color: this.makeStickyHeaderTextColor(
                                      shrinkOffset, false),
                                )),
                          ),
                          Text(
                            this.subtitle,
                            maxLines: 1,
                            softWrap: true,
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .merge(TextStyle(
                                  color: this.makeStickyHeaderTextColor(
                                      shrinkOffset, false),
                                )),
                          ),
                        ],
                      ),
                    ],
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
