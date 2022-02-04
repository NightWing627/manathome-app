import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import '../models/product_details2.dart';
import '../models/variant.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/helper.dart';
import '../controllers/product_controller.dart';
import '../elements/ClearCartWidget.dart';

// ignore: must_be_immutable
class ProductBox2Widget extends StatefulWidget {
  ProductBox2Widget(
      {Key key,
      this.choice,
      this.con,
      this.shopId,
      this.shopName,
      this.subtitle,
      this.km,
      this.shopTypeID,
      this.latitude,
      this.longitude,
      this.callback,
      this.focusId})
      : super(key: key);
  final ProductDetails2 choice;
  final ProductController con;
  final String shopId;
  final String shopName;
  final String subtitle;
  final String km;
  final int shopTypeID;
  final String latitude;
  final String longitude;
  Function callback;
  final int focusId;

  @override
  _ProductBox2WidgetState createState() => _ProductBox2WidgetState();
}

class _ProductBox2WidgetState extends StateMVC<ProductBox2Widget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.only(
          left: 10,
          top: 5,
          right: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
            widget.choice.variant.length,
            (index) {
              variantModel _variantData =
                  widget.choice.variant.elementAt(index);
              return _variantData.selected
                  ? Row(children: [
                      InkWell(
                        onTap: () {
                          // widget.con.view_product(widget.choice);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(top: 10, right: 10),
                            child: CachedNetworkImage(
                              imageUrl: _variantData.image,
                              placeholder: (context, url) =>
                                  new CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                              fit: BoxFit.fitHeight,
                              width: 110,
                              height: 120,
                            )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 2, right: 5),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 6),
                                        height: 35,
                                        child: Text(widget.choice.product_name,
                                            overflow: TextOverflow.fade,
                                            maxLines: 2,
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .backgroundColor
                                                    .withOpacity(0.8))),
                                      ),
                                      Wrap(
                                          alignment: WrapAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                Helper.pricePrint(
                                                    _variantData.sale_price),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 4),
                                              child: Text(
                                                Helper.pricePrint(
                                                    _variantData.strike_price),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .merge(TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough)),
                                              ),
                                            ),
                                          ]),
                                      SizedBox(height: 3),
                                      _variantData.discount != ''
                                          ? Text(
                                              ' ${_variantData.discount}% OFF',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .merge(TextStyle(
                                                    color: Colors.green,
                                                  )),
                                            )
                                          : Text(''),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              AvailableQuantityHelper.exit(
                                                      context,
                                                      widget.choice.variant,
                                                      widget
                                                          .choice.product_name,
                                                      _variantData.selected)
                                                  .then((receivedLocation) {
                                                if (receivedLocation != null) {
                                                  widget.choice.variant
                                                      .forEach((_l) {
                                                    setState(() {
                                                      if (_l.variant_id ==
                                                          receivedLocation) {
                                                        _l.selected = true;
                                                      } else {
                                                        _l.selected = false;
                                                      }
                                                    });
                                                  });
                                                }
                                              });
                                            },
                                            child: Container(
                                                height: 30,
                                                width: 100,
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey[300],
                                                    )),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        '${_variantData.quantity}${_variantData.unit}'),
                                                    Icon(Icons.arrow_drop_down,
                                                        size: 19,
                                                        color: Colors.grey)
                                                  ],
                                                )),
                                          ),
                                          1 ==
                                                  widget.con
                                                      .checkProductIdCartVariant(
                                                          widget.choice.id,
                                                          _variantData
                                                              .variant_id)
                                              ? InkWell(
                                                  onTap: () {
                                                    widget.con.checkShopAdded(
                                                        widget.choice,
                                                        'cart',
                                                        _variantData,
                                                        widget.shopId,
                                                        ClearCartShow,
                                                        widget.shopName,
                                                        widget.subtitle,
                                                        widget.km,
                                                        widget.shopTypeID,
                                                        widget.latitude,
                                                        widget.longitude,
                                                        widget.callback,
                                                        widget.focusId);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 10,
                                                        bottom: 7),
                                                    child: Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        height: 30,
                                                        /*width: MediaQuery.of(context).size.width * 0.25,*/
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .secondary
                                                              .withOpacity(1),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              S.of(context).add,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .transparent),
                                                            ),
                                                            Text(
                                                                S
                                                                    .of(context)
                                                                    .add,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .subtitle2
                                                                    .merge(TextStyle(
                                                                        color: Theme.of(context)
                                                                            .primaryColorLight,
                                                                        fontWeight:
                                                                            FontWeight.w600))),
                                                            SizedBox(width: 5),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                              ),
                                                              height: double
                                                                  .infinity,
                                                              width: 30,
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () {},
                                                                  icon: Icon(
                                                                      Icons
                                                                          .add),
                                                                  iconSize: 18,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorLight),
                                                            )
                                                          ],
                                                        )),
                                                  ))
                                              : InkWell(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                    ),
                                                    child: Wrap(
                                                        alignment: WrapAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                widget.con.decrementQtyVariant(
                                                                    widget
                                                                        .choice
                                                                        .id,
                                                                    _variantData
                                                                        .variant_id);
                                                              });
                                                            },
                                                            child: Icon(
                                                                Icons
                                                                    .remove_circle,
                                                                color: Theme.of(
                                                                        context)
                                                                    .backgroundColor,
                                                                size: 27),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.022,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5),
                                                            child: Text(
                                                                widget.con.showQtyVariant(
                                                                    widget
                                                                        .choice
                                                                        .id,
                                                                    _variantData
                                                                        .variant_id),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.022,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                widget.con.incrementQtyVariant(
                                                                    widget
                                                                        .choice
                                                                        .id,
                                                                    _variantData
                                                                        .variant_id);
                                                              });
                                                            },
                                                            child: Icon(
                                                                Icons
                                                                    .add_circle,
                                                                color: Theme.of(
                                                                        context)
                                                                    .backgroundColor,
                                                                size: 27),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      widget.choice.variant.length > 1
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 20),
                                                  child: Text(
                                                    S.of(context).customizable,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption,
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      /**   Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width:120,
                                          child:Text('This product available at 12.00 pm to 1.00 pm',
                                              style:TextStyle(fontSize:9,fontWeight: FontWeight.w700)
                                          ),
                                        ),


                                      ],
                                    ), */

                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ]

                              /*       return _variantData.selected?*/

                              ),
                        ),
                      ),
                    ])
                  : Container();
            },
          ),
        ),
      ),
      /** Positioned(
            top:10,left:20,
            child:Stack(
                children:[
                  Container(
                      width:30,height:70,
                      child:Image(image:AssetImage('assets/img/toplable.png'))
                  ),
                  Align(
                      alignment: Alignment.center,
                      child:Container(
                          margin: EdgeInsets.only(top:18,left:3),
                          alignment: Alignment.center,
                          child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Text('20%',
                                  style: TextStyle(color:Theme.of(context).primaryColorLight,fontSize: 10,fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text('OFF',
                                  style: TextStyle(color:Theme.of(context).primaryColorLight,fontSize: 10,fontWeight: FontWeight.w700
                                  ),
                                )
                              ]
                          )
                      )
                  ),


                ])
        ) */
    ]);
  }

  // ignore: non_constant_identifier_names
  void ClearCartShow() {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: size.height * 0.3,
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
                      padding: EdgeInsets.only(
                          left: size.width * 0.05, right: size.width * 0.05),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClearCart(),
                            ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          top: 5,
                          bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 0.44,
                            height: 45.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Colors.grey[200], width: 1)
                                /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                  child: Text(
                                S.of(context).cancel,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Container(
                            width: size.width * 0.44,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(30),
                              /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {
                                widget.con.clearCart();
                              },
                              child: Center(
                                  child: Text(
                                S.of(context).clear_cart,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                            ),
                          ),
                        ],
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

class AvailableQuantityHelper {
  static exit(context, variant, name, select) => showDialog(
      context: context,
      builder: (context) => AvailableQuantityPopup(
            variantList: variant,
            title: name,
            selected: select,
          ));
}

// ignore: must_be_immutable
class AvailableQuantityPopup extends StatefulWidget {
  AvailableQuantityPopup({Key key, this.variantList, this.title, this.selected})
      : super(key: key);
  List<variantModel> variantList;
  String title;
  bool selected;
  @override
  _AvailableQuantityPopupState createState() => _AvailableQuantityPopupState();
}

class _AvailableQuantityPopupState extends State<AvailableQuantityPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
      insetPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.09,
        left: MediaQuery.of(context).size.width * 0.09,
        right: MediaQuery.of(context).size.width * 0.09,
        bottom: MediaQuery.of(context).size.width * 0.09,
      ),
    );
  }

  _buildChild(BuildContext context) => SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Text(S.of(context).available_quantity,
                    style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  )),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .merge(TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              ListView.separated(
                itemCount: widget.variantList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  variantModel _variantData =
                      widget.variantList.elementAt(index);

                  return Container(
                    width: double.infinity,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {
                        widget.variantList.forEach((_l) {
                          setState(() {
                            _l.selected = false;
                          });
                        });

                        _variantData.selected = true;

                        Navigator.pop(context, _variantData.variant_id);
                      },
                      padding: EdgeInsets.all(10),
                      color: _variantData.selected
                          ? Theme.of(context).backgroundColor.withOpacity(0.8)
                          : null,
                      child: RichText(
                        text: new TextSpan(children: [
                          TextSpan(
                            text:
                                '${_variantData.quantity}  ${_variantData.unit} ',
                            style: _variantData.selected
                                ? Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .merge(TextStyle(
                                      color: Colors.white,
                                    ))
                                : Theme.of(context).textTheme.headline1.merge(
                                    TextStyle(
                                        color: Theme.of(context).disabledColor,
                                        fontWeight: FontWeight.w500)),
                          ),
                          TextSpan(
                              text:
                                  Helper.pricePrint(_variantData.strike_price),
                              style: _variantData.selected
                                  ? Theme.of(context).textTheme.headline1.merge(
                                      TextStyle(
                                          color: Colors.white,
                                          decoration:
                                              TextDecoration.lineThrough))
                                  : Theme.of(context).textTheme.headline1.merge(
                                      TextStyle(
                                          color:
                                              Theme.of(context).disabledColor,
                                          fontWeight: FontWeight.w500,
                                          decoration:
                                              TextDecoration.lineThrough))),
                          TextSpan(
                            text: Helper.pricePrint(_variantData.sale_price),
                            style: _variantData.selected
                                ? Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .merge(TextStyle(
                                      color: Colors.white,
                                    ))
                                : Theme.of(context).textTheme.headline1.merge(
                                    TextStyle(
                                        color: Theme.of(context).disabledColor,
                                        fontWeight: FontWeight.w500)),
                          )
                        ]),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      )),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}
