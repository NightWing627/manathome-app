import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import '../repository/order_repository.dart';
import '../models/product_details2.dart';
import '../models/variant.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/helper.dart';
import '../controllers/product_controller.dart';
import '../elements/ClearCartWidget.dart';
import 'AddonsWidget.dart';

// ignore: must_be_immutable
class RestaurantProductBox extends StatefulWidget {
  RestaurantProductBox(
      {Key key,
      this.popperShow,
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
  final focusId;
  bool popperShow;
  Function callback;

  @override
  _RestaurantProductBoxState createState() => _RestaurantProductBoxState();
}

class _RestaurantProductBoxState extends StateMVC<RestaurantProductBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: List<Widget>.generate(widget.choice.variant.length, (index) {
          variantModel _variantData = widget.choice.variant.elementAt(index);
          return _variantData.selected ? Row(
              children: [

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
                                border: Border.all(color: Colors.orange, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.transparent, // 0 = Colored, 1 = Black & White
                                  BlendMode.saturation,
                                ),
                                child:ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: _variantData.image!='no_image'?CachedNetworkImage(
                                      imageUrl: _variantData.image,
                                      placeholder: (context, url) => new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => new Icon(Icons.error),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      height: MediaQuery.of(context).size.width * 0.28,
                                    ):CachedNetworkImage(
                                      imageUrl: _variantData.image,
                                      placeholder: (context, url) => new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => new Icon(Icons.error),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      height: MediaQuery.of(context).size.width * 0.28,
                                    )),
                              ),
                            )
                          ]),
                    ),
                  ],
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  padding: const EdgeInsets.only(top: 6),
                                  // height: 70,
                                  child: Text(widget.choice.product_name.toUpperCase(),
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15),
                                  ),
                                ),

                                SizedBox(height: 3),
                                /**    Text(
                                    '${widget.choice..toString()} % ${S.of(context).offer}',
                                    style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                    color: Theme.of(context).accentColor,
                                    )),
                                    ), */
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8, top: 4),
                                          child: Text(
                                            Helper.pricePrint(_variantData.strike_price),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .subtitle2
                                                .merge(TextStyle(decoration: TextDecoration.lineThrough)),
                                          ),
                                        ),
                                        Text(Helper.pricePrint(_variantData.sale_price), style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline3),
                                      ],
                                    ),
                                    SizedBox(width: 70,),
                                    InkWell(

                                      onTap: () {

                                        if(currentCheckout.value.shopId==widget.shopId || currentCheckout.value.shopId==null) {
                                          variantPop(
                                              widget.choice,
                                              widget.choice.product_name,
                                              widget.con,
                                              widget.shopName,
                                              widget.subtitle,
                                              widget.km,
                                              widget.shopTypeID,
                                              widget.latitude, widget.longitude, widget.focusId);
                                        }else{
                                          ClearCartShow();
                                        }

                                      },
                                      child: Container(
                                          height: 30,
                                          width: 61,
                                          padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(6),
                                                  bottomRight: Radius.circular(6)
                                              ),
                                              border: Border.all(
                                                width: 1, color: Colors.orange,
                                              )
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width:20,
                                                child:Text('${_variantData.quantity}',
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),

                                              Icon(Icons.arrow_drop_down, size: 25, color: Colors.orange)
                                            ],
                                          )

                                      ),
                                    ),
                                    1 == widget.con.checkProductIdCartVariant(widget.choice.id, _variantData.variant_id)
                                        ? InkWell(
                                        onTap: () {
                                          if(currentCheckout.value.shopId==widget.shopId || currentCheckout.value.shopId==null) {


                                            variantPop(widget.choice, widget.choice.product_name, widget.con, widget.shopName, widget.subtitle, widget.km,
                                                widget.shopTypeID, widget.latitude, widget.longitude, widget.focusId);
                                          }else{
                                            ClearCartShow();
                                          }
                                          //   widget.con.checkShopAdded(widget.choice, 'cart',_variantData, widget.shopId,ClearCartShow);


                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 0),
                                          child: Container(
                                              alignment: Alignment.centerRight,
                                              height: 55,
                                              width: 55,
                                              /*width: MediaQuery.of(context).size.width * 0.25,*/
                                              child: Image.asset('assets/img/ic_carrello.png')),
                                        )
                                      /*child: Padding(
                                          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 7),
                                          child: Container(
                                              height: 30,
                                              *//*width: MediaQuery.of(context).size.width * 0.25,*//*
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey[300],
                                                  )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    child: Text(
                                                      '${_variantData.quantity}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  Icon(Icons.arrow_drop_down,
                                                      size: 19,
                                                      color: Colors.grey)
                                                ],
                                              )),
                                        )*/
                                        )
                                        : InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: 1 ==
                                                widget.con
                                                    .checkProductIdCartVariant(
                                                        widget.choice.id,
                                                        _variantData.variant_id)
                                            ? InkWell(
                                                onTap: () {
                                                  if (currentCheckout
                                                              .value.shopId ==
                                                          widget.shopId ||
                                                      currentCheckout
                                                              .value.shopId ==
                                                          null) {
                                                    variantPop(
                                                        widget.choice,
                                                        widget.choice
                                                            .product_name,
                                                        widget.con,
                                                        widget.shopName,
                                                        widget.subtitle,
                                                        widget.km,
                                                        widget.shopTypeID,
                                                        widget.latitude,
                                                        widget.longitude,
                                                        widget.focusId);
                                                  } else {
                                                    ClearCartShow();
                                                  }
                                                  //   widget.con.checkShopAdded(widget.choice, 'cart',_variantData, widget.shopId,ClearCartShow);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 10,
                                                      bottom: 7),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    height: 30,

                                                    //width: MediaQuery.of(context).size.width * 0.25,

                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Theme.of(context)
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
                                                        Text(S.of(context).add,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle2
                                                                .merge(TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColorLight,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))),
                                                        SizedBox(width: 5),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                topRight: Radius
                                                                    .circular(
                                                                        5)),
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                          ),
                                                          height:
                                                              double.infinity,
                                                          width: 30,
                                                          child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                  Icons.add),
                                                              iconSize: 18,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorLight),
                                                        )
                                                      ],
                                                    ),
                                                  ),
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
                                                                  widget.choice
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
                                                                  widget.choice
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
                                                                  widget.choice
                                                                      .id,
                                                                  _variantData
                                                                      .variant_id);
                                                            });
                                                          },
                                                          child: Icon(
                                                              Icons.add_circle,
                                                              color: Theme.of(
                                                                      context)
                                                                  .backgroundColor,
                                                              size: 27),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                      ))],
                                    ),
                                    widget.choice.variant.length > 1
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 20),
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
                : Container(
                    child: Text('111'),
                  );
          },
        ),
      ),
    );
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

  void variantPop(product, title, con, shopName, subtitle, km, shopTypeId,
      latitude, longitude, focusId) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: product.categoryAddons.isEmpty?MediaQuery.of(context).size.height*0.6:
              MediaQuery.of(context).size.height,
              color: Color(0xff737373),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
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
                                title,
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
                              AddonsPart(
                                product: product,
                                con: con,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: Container(
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  // ignore: unnecessary_statements
                                  widget.choice.variant;
                                });

                                widget.con.addToCartRestaurant(
                                    widget.choice,
                                    'cart',
                                    widget.choice.variant,
                                    widget.shopId,
                                    widget.choice.addon,
                                    shopName,
                                    subtitle,
                                    km,
                                    shopTypeId,
                                    latitude,
                                    longitude,
                                    widget.callback,
                                    widget.focusId);
                              },
                              padding: EdgeInsets.all(15),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(1),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: new RichText(
                                        text: new TextSpan(
                                            text: S.of(context).item_total,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColorLight)),
                                            children: [
                                              new TextSpan(
                                                text:
                                                    ' ${Helper.pricePrint(widget.con.calculateAmount())}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .merge(TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight)),
                                              )
                                            ]),
                                      ),
                                    ),
                                    Container(
                                        child: Text(
                                      S.of(context).add_item,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .merge(TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorLight)),
                                    )),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}
