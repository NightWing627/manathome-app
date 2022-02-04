import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/order_controller.dart';
import 'package:multisuperstore/src/models/order_details.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class ShopRating extends StatefulWidget {
  OrderDetailsModel invoiceDetailsData = new OrderDetailsModel();
  ShopRating({Key key, this.invoiceDetailsData}) : super(key: key);
  @override
  _ShopRatingState createState() => _ShopRatingState();
}

class _ShopRatingState extends StateMVC<ShopRating> {

   OrderController _con;
  _ShopRatingState() : super(OrderController()) {
    _con = controller;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
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
                            widget.invoiceDetailsData.addressShop.username,
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.left,
                          ),

                      ]),
                    ),

                  ],
                ),


              ])
        ),
      ),
      body: Container(
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
                              SizedBox(height:10),

                              SizedBox(height:30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 30,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      _con.shopRatingData.rate = rating;
                                    },

                                  ),
                                ],
                              ),







                            ]),
                          ),

                          Container(
                            width:double.infinity,
                            height: 8,
                            decoration: BoxDecoration(
                                color:Theme.of(context).dividerColor
                            ),
                          ),
                         Padding(
                           padding: EdgeInsets.only(top:15,left: 15, right: 15,),
                           child:Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children:[
                                 Text(S.of(context).what_did_the_restaurant_impress_you_with,
                                 style:Theme.of(context).textTheme.subtitle1
                                 )
                               ]
                           ),
                         ),
                          Padding(
                            padding: EdgeInsets.only(top:15,left: 25, right:25,bottom:20),
                            child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  InkWell(
                                    onTap: (){

                                      setState(() {
                                        _con.shopRatingData.taste = true;
                                      });
                                    },
                                    child: Column(
                                      children:[
                                        Container(
                                            width:60,height:60,
                                            padding: EdgeInsets.all(7),
                                            decoration: BoxDecoration(shape: BoxShape.circle,
                                                color: _con.shopRatingData.taste?Colors.green:Colors.black.withOpacity(0.1)
                                            ),
                                            child:Image(image:AssetImage('assets/img/smiley.png'))
                                        ),
                                        SizedBox(height:10),
                                        Text(S.of(context).taste,style:Theme.of(context).textTheme.bodyText1)
                                      ]
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        _con.shopRatingData.packing = true;
                                      });

                                    },
                                    child: Column(
                                        children:[
                                          Container(
                                              width:60,height:60,
                                              padding: EdgeInsets.all(7),
                                              decoration: BoxDecoration(shape: BoxShape.circle,
                                                  color: _con.shopRatingData.packing?Colors.green:Colors.black.withOpacity(0.1)
                                              ),
                                              child:Image(image:AssetImage('assets/img/package.png'))
                                          ),
                                          SizedBox(height:10),
                                          Text(S.of(context).packaging,style:Theme.of(context).textTheme.bodyText1)
                                        ]
                                    ),
                                  ),

                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            _con.shopRatingData.portion = true;
                                          });


                                        },
                                    child: Column(
                                        children:[
                                          Container(
                                              width:60,height:60,
                                              padding: EdgeInsets.all(7),
                                              decoration: BoxDecoration(shape: BoxShape.circle,
                                                  color:_con.shopRatingData.portion?Colors.green:Colors.black.withOpacity(0.1)
                                              ),
                                              child:Image(image:AssetImage('assets/img/portion.png'))
                                          ),
                                          SizedBox(height:10),
                                          Text(S.of(context).portion,style:Theme.of(context).textTheme.bodyText1)
                                        ]
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          Container(
                            width:double.infinity,
                            height: 8,
                            decoration: BoxDecoration(
                                color:Theme.of(context).dividerColor
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top:10,left: 15, right: 15,),
                              width: double.infinity,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Container(
                                    margin: EdgeInsets.only(top:0),
                                    width: double.infinity,
                                    child: TextField(
                                        textAlign: TextAlign.left,
                                        autocorrect: true,
                                        onChanged: (e){
                                          _con.shopRatingData.message = e;
                                        },
                                        keyboardType: TextInputType.text,
                                        style: Theme.of(context).textTheme.bodyText1,
                                        decoration: InputDecoration(
                                          labelText: 'Tell us what you liked most',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .merge(TextStyle(color: Colors.grey)),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context).colorScheme.secondary,
                                              width: 1.0,
                                            ),
                                          ),
                                        ))),
                                Text(S.of(context).your_word_make_grocery_a_better_place_you_are_the_influence,
                                    style:Theme.of(context).textTheme.caption
                                )

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
                padding: const EdgeInsets.all(10),
                child: Container(
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
                        _con.shopRatingData.vendor = widget.invoiceDetailsData.addressShop.id;
                        _con.submitShopRating(widget.invoiceDetailsData.saleCode);
                      },
                      padding: EdgeInsets.all(15),
                      color: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        'SUBMIT YOUR FEEDBACK ',
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .merge(TextStyle(color: Theme.of(context).primaryColorLight)),
                      )),
                ),
              ),
            ),
          ],
        ),
      )
    );




  }
}



















