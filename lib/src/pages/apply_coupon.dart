import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/elements/OfferDetailsWidget.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../controllers/cart_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';

class ApplyCoupon extends StatefulWidget {
  @override
  _ApplyCouponState createState() => _ApplyCouponState();
}

class _ApplyCouponState extends StateMVC<ApplyCoupon> {
  CartController _con;

  _ApplyCouponState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCoupons();
    super.initState();
  }

  int dropDownValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              S.of(context).apply_coupons,
              style: Theme.of(context).textTheme.bodyText1,
            )),
        body: Container(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).dividerColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.only(left: 15.0, top: 2.0, bottom: 2.0, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                          borderRadius: BorderRadius.circular(2.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                style: Theme.of(context).textTheme.subtitle2,
                                decoration: InputDecoration(
                                  hintText: S.of(context).enter_coupon_code,
                                  hintStyle: Theme.of(context).textTheme.bodyText2,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Text(
                              S.of(context).apply,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20), child: Text(S.of(context).available_coupons)),
                  ],
                ),
              ),
              1==2
                  ? EmptyOrdersWidget()
                  : OfferDetailsPart()
              /**  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _con.couponList.length,
                      itemBuilder: (context, index) {
                        Coupons _couponData = _con.couponList.elementAt(index);
                        return Column(
                          children: [
                            /*Padding(
                                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    /*Stack(clipBehavior: Clip.none, children: [
                                      Container(
                                          width: 60,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            color: Colors.orange[100],
                                          ),
                                          child: Icon(Icons.card_giftcard, color: Theme.of(context).accentColor)),
                                      Container(
                                        margin: EdgeInsets.only(left: 55),
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          color: Colors.orange[100],
                                        ),
                                        child: Center(
                                            child: Text(
                                          _couponData.code,
                                          style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).backgroundColor)),
                                        )),
                                      ),
                                    ]),*/
                                    GestureDetector(
                                        onTap: () {
                                          _con.applyCoupon(_couponData.code, _couponData.discount_type, int.parse(_couponData.discount_value));
                                        },
                                        child: Text(
                                          S.of(context).apply,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .merge(TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.w900)),
                                        )),
                                  ],
                                )),*/
                            Padding(
                                padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                                child: Text(
                                  '${S.of(context).get} ${_couponData.discount_value} ${_couponData.discount_type}  using ${S.of(context).this_code}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                              child: CustomDividerView(
                                dividerHeight: 1.0,
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 15),
                                child: Text(
                                  '${S.of(context).use_code} ${_couponData.code} & ${S.of(context).get} ${_couponData.discount_value} ${_couponData.discount_type} ${S.of(context).on_your_order_above}  ${_couponData.minimum_buy}',
                                  style: Theme.of(context).textTheme.caption,
                                )),
                          ],
                        );
                      }), */
            ],
          ),
        )));
  }
}
