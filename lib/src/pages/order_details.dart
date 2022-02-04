import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/order_controller.dart';
import 'package:multisuperstore/src/elements/EmptyOrdersWidget.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/cart_responce.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'map.dart';

// ignore: must_be_immutable
class OrderDetails extends StatefulWidget {
  String orderId;
  OrderDetails({Key key, this.orderId}) : super(key: key);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends StateMVC<OrderDetails> {

  OrderController _con;

  _OrderDetailsState() : super(OrderController()) {
    _con = controller;
  }


  void initState() {
    // TODO: implement initState
    super.initState();

    _con.listenForInvoiceDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title:Container(
              width: double.infinity,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          'ORDER #${widget.orderId}',
                          style: Theme.of(context).textTheme.subtitle2,
                          textAlign: TextAlign.left,
                        ),

                      ]),
                    ),

                  ],
                ),
                _con.invoiceDetailsData.status!=null? Text(
                  '${_con.invoiceDetailsData.status} | Item ${Helper.pricePrint(_con.invoiceDetailsData.payment.grand_total)}',
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.left,
                ):Text(''),
              ])
          ),
        ),
        body: _con.invoiceDetailsData.productDetails.isEmpty? EmptyOrdersWidget():Container(
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
                          Column(children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: EdgeInsets.only(top: 10),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      return Column(children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(bottom: 20),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:EdgeInsets.only(top:6),
                                                  child: Icon(Icons.location_on, color: Theme.of(context).disabledColor),
                                                ),

                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                    Text(_con.invoiceDetailsData.addressShop.username, style: Theme.of(context).textTheme.bodyText1),
                                                    Text(
                                                      _con.invoiceDetailsData.addressShop.addressSelect,
                                                      style: Theme.of(context).textTheme.bodyText2,
                                                      textAlign: TextAlign.left,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ]),
                                                ),
                                              ]),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(bottom: 20),
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                  color: Theme.of(context).dividerColor,
                                                  width: 1,
                                                )),
                                          ),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Padding(
                                              padding:EdgeInsets.only(top:6),
                                              child: Icon(Icons.home, color: Theme.of(context).disabledColor),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                Text(currentUser.value.name, style: Theme.of(context).textTheme.bodyText1),
                                                Text(
                                                    _con.invoiceDetailsData.addressUser.addressSelect,
                                                  style: Theme.of(context).textTheme.bodyText2,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ]),
                                            ),
                                          ]),
                                        ),
                                      ]);
                                    }),




                                _con.invoiceDetailsData.status=='Completed'?   Container(
                                    padding: EdgeInsets.only(top:20),
                                    width: double.infinity,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:EdgeInsets.only(top:6),
                                            child: Icon(Icons.check, color: Theme.of(context).colorScheme.secondary),
                                          ),
                                          Expanded(
                                            child:Padding(
                                              padding: EdgeInsets.only(top:3,left:8,right:20),
                                              child: Text(
                                                'Order delivered on october 20.30 by haribabu',
                                                style: Theme.of(context).textTheme.bodyText2,
                                                textAlign: TextAlign.left,
                                              ),
                                            ),

                                          ),


                                        ],
                                      ),

                                    ])
                                ):Container(),





                              ]),
                            ),

                            Container(
                                width:double.infinity,
                                decoration: BoxDecoration(
                                    color:Theme.of(context).dividerColor
                                ),
                                padding: EdgeInsets.all(20),
                                child:Text(S.of(context).bill_details)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, children: [

                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: _con.invoiceDetailsData.productDetails.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: EdgeInsets.only(top: 10),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      CartResponce _orderDetails = _con.invoiceDetailsData.productDetails.elementAt(index);
                                      String addonName;
                                      _orderDetails.addon.forEach((element) {
                                        addonName = element.name;
                                      });
                                      return Container(
                                        padding: EdgeInsets.only(top:10,bottom:15),
                                        width:double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                color: Theme.of(context).dividerColor,
                                                width: 1,
                                              )),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            _con.invoiceDetailsData.shopTypeId=='2'? Padding(
                                              padding:EdgeInsets.only(top:10),
                                              child:  Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Theme.of(context).colorScheme.secondary,
                                                  ),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).colorScheme.secondary,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  width: 6.0,
                                                  height: 6.0,
                                                ),
                                              ),
                                            ):Container(),
                                            Expanded(
                                              child:Padding(
                                                  padding: EdgeInsets.only(top:3,left:10),
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:[
                                                        Text(
                                                          ' ${_orderDetails.product_name} ${_orderDetails.quantity} ${_orderDetails.unit} x ${_orderDetails.qty}',
                                                          style: Theme.of(context).textTheme.bodyText1,
                                                          textAlign: TextAlign.left,
                                                        ),
                                                        _orderDetails.addon.length!=0?Text(
                                                         addonName,
                                                          style: Theme.of(context).textTheme.bodyText2,
                                                          textAlign: TextAlign.left,
                                                        ):Text(''),
                                                      ]
                                                  )
                                              ),

                                            ),

                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                  padding: EdgeInsets.only(top:10,),
                                                  child: Text(Helper.pricePrint(_orderDetails.price))
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ]),),
                            Container(
                                padding: EdgeInsets.only(left: 15, right: 15,),
                                width: double.infinity,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [





                                  Container(
                                    padding: EdgeInsets.only(top:20),
                                    child:Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text(S.of(context).item_total,style: Theme.of(context).textTheme.subtitle2,),
                                            ),
                                            SizedBox(width:10),
                                            Text(Helper.pricePrint(_con.invoiceDetailsData.payment.sub_total),style: Theme.of(context).textTheme.subtitle2,),
                                          ],
                                        ),
                                        SizedBox(height: 5,),

                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text(S.of(context).delivery_partner_fee,style: Theme.of(context).textTheme.subtitle2,),
                                            ),
                                            SizedBox(width:10),
                                            Text(Helper.pricePrint(_con.invoiceDetailsData.payment.delivery_fees),style: Theme.of(context).textTheme.subtitle2,),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text(S.of(context).delivery_partner_tips,style: Theme.of(context).textTheme.subtitle2,),
                                            ),
                                            SizedBox(width:10),
                                            Text(Helper.pricePrint(_con.invoiceDetailsData.payment.delivery_tips),style: Theme.of(context).textTheme.subtitle2,),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text('Tax',style: Theme.of(context).textTheme.subtitle2,),
                                            ),
                                            SizedBox(width:10),
                                            Text(Helper.pricePrint(_con.invoiceDetailsData.payment.tax),style: Theme.of(context).textTheme.subtitle2,),
                                          ],
                                        ),
                                        SizedBox(height: 5,),

                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(top:10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                  color: Theme.of(context).dividerColor,
                                                  width: 1,
                                                )),
                                          ),
                                        ),
                                        SizedBox(height:10),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child:Text('Pay ${_con.invoiceDetailsData.payment.method}',style: Theme.of(context).textTheme.subtitle2,),
                                            ),
                                            SizedBox(width:10),
                                            Text('${S.of(context).bill_total} ${Helper.pricePrint(_con.invoiceDetailsData.payment.grand_total)}',style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(fontWeight: FontWeight.w600)),),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                ])
                            ),



                          ]),
                        ]),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left:0),
                  child: _con.invoiceDetailsData.status!='Completed'?Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width:1,color: Colors.grey[200],
                          ),
                        )
                    ),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        onPressed: () {
                          if(_con.invoiceDetailsData.status!='Cancelled' &&  _con.invoiceDetailsData.status!='Completed') {

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapWidget(orderId: widget.orderId,pageType: 'viewDetails',)));
                          }
                        },
                        padding: EdgeInsets.all(15),
                        color: Colors.grey[200],
                        child: Text(
                          _con.invoiceDetailsData.status,
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .merge(TextStyle(color: Colors.deepOrange)),
                        )),
                  ): _con.invoiceDetailsData.status=='Completed' && _con.invoiceDetailsData.rating=='0'?InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed('/ShopRating', arguments: _con.invoiceDetailsData);
                    },
                    child: Column(

                      children:[
                        Text('Give your rating '),
                        SizedBox(height:5),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          tapOnlyMode: true,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 25,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },

                        ),
                        SizedBox(height:10),
                      ]
                    ),
                  ):Column(
                      children:[
                        Text('Your rating is ${_con.invoiceDetailsData.rating}'),
                        SizedBox(height:5),
                        RatingBar.builder(
                          initialRating: double.parse(_con.invoiceDetailsData.rating),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          tapOnlyMode: false,
                          itemSize: 25,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },

                        ),
                        SizedBox(height:10),
                      ]
                  ),
                ),
              ),
            ],
          ),
        )
    );




  }
}















