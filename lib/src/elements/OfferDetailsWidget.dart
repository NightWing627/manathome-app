// ignore: must_be_immutable

import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/vendor_controller.dart';
import 'package:multisuperstore/src/models/coupon.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'RectangleLoaderWidget.dart';

// ignore: must_be_immutable
class OfferDetailsPart extends StatefulWidget {
  String pageType;
  String shopId;
  OfferDetailsPart({Key key, this.pageType, this.shopId}) : super(key: key);
  @override
  _OfferDetailsPartState createState() => _OfferDetailsPartState();
}

class _OfferDetailsPartState extends StateMVC<OfferDetailsPart> {

  VendorController _con;

  _OfferDetailsPartState() : super(VendorController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.pageType=='vendor') {
      _con.listenForOffers(widget.shopId);
    }

  }
  @override
  Widget build(BuildContext context) {
    return  _con.couponList.isEmpty?RectangleLoaderWidget():Column(children: [

      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount:  _con.couponList.length,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(top: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {

              Coupon _coupon = _con.couponList.elementAt(index);
                return Container(child:Container(
                    padding:EdgeInsets.only(left:0,right:0,top:10,bottom:10),
                    child:Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/img/couponcurve1.png'),
                                fit: BoxFit.fill
                            ),

                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                              ),
                            ]),
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Container(
                                padding:EdgeInsets.only(top:20,left:20,right:20),
                                child:Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            children:[
                                              Wrap(
                                                children: [
                                                  Container(
                                                    padding:EdgeInsets.only(top:2),
                                                    child:Icon(Icons.access_time,color:Colors.pink,size:15),
                                                  ),

                                                  SizedBox(width:7),
                                                  Text(_coupon.title,style:Theme.of(context).textTheme.subtitle1)
                                                ],
                                              ),
                                             widget.pageType!='vendor'?Container(
                                               child:Text(S.of(context).apply,
                                               style: Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorDark,fontWeight: FontWeight.w800)),
                                               )
                                             ):Container(),

                                            ]
                                          ),

                                          Container(
                                              padding: EdgeInsets.only(top:30),
                                              child:Row(
                                                  children:[
                                                    Text(_coupon.discount.toString(),style:TextStyle(fontSize:30)),
                                                    SizedBox(width:2),
                                                    Container(
                                                        padding: EdgeInsets.only(top:15),
                                                        child:Text('OFF')
                                                    ),

                                                    Container(
                                                      padding: EdgeInsets.only(left:20),
                                                      child:Stack(clipBehavior: Clip.none, children: [
                                                      Container(
                                                          width: 50,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(0),
                                                              topRight: Radius.circular(10),
                                                              bottomRight: Radius.circular(10),
                                                            ),
                                                            color: Colors.orange[100],
                                                          ),
                                                          child: Icon(Icons.card_giftcard, size:18,color: Theme.of(context).colorScheme.secondary)),
                                                      Container(
                                                        margin: EdgeInsets.only(left: 45),
                                                        width: 70,
                                                        height: 30,
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
                                                              _coupon.terms,
                                                              style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).backgroundColor)),
                                                            )),
                                                      ),
                                                    ]),),

                                                  ]
                                              )
                                          )

                                        ],
                                      ),
                                    ),
                                    Container(
                                        width:60,height:60,
                                        child:Image(image:NetworkImage(_coupon.image),
                                          width:60,
                                        )
                                    )
                                  ],
                                ),
                              ),




                              Container(
                                padding: EdgeInsets.only(left:27,top:10,bottom:20,right:27),
                                child:Text('maximum discount up to l125 on orders above lsfvj weiufgweiugfiuwef weiufgewiufgweiu weiufgweiufewiuf weiufgweiuf299',
                                    overflow: TextOverflow.ellipsis,maxLines: 2,
                                    style:Theme.of(context).textTheme.caption),
                              ),



                            ]
                        )
                    )
                ),);

              }, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 5);
            },),


          ])),

    ]);
  }
}
