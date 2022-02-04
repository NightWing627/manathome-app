import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/components/constants.dart';
import 'package:multisuperstore/src/controllers/home_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CircularLoadingWidget.dart';
import 'NoShopFoundPopupWidget.dart';
import 'NoShopFoundWidget.dart';
// ignore: must_be_immutable
class VendorFullDetailsPopWidget extends StatefulWidget {

  String shopId;
  VendorFullDetailsPopWidget({Key key,  this.shopId}) : super(key: key);
  @override
  _VendorFullDetailsPopWidgetState createState() => _VendorFullDetailsPopWidgetState();
}

class _VendorFullDetailsPopWidgetState extends StateMVC<VendorFullDetailsPopWidget> {
  HomeController _con;
  _VendorFullDetailsPopWidgetState() : super(HomeController()) {
    _con = controller;

  }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _con.getBusinessCard(widget.shopId);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _con.loader?contentBox(context):CircularLoadingWidget(height: 200),
    );
  }
  contentBox(context){
    return  _con.businessCardData.preview=='not_found'?NoShopFoundPopupWidget(): Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: <Widget>[

        Container(
          height:560,
          padding: EdgeInsets.only(top:0
          ),

          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ]
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              ClipRRect(
                //borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft:Radius.circular(0),
                    bottomRight:Radius.circular(0),
                  ),

                  child:
                  Image(image: _con.businessCardData.coverImage=='no_image'?AssetImage('assets/img/loginbg.jpg'):NetworkImage(_con.businessCardData.coverImage),
                      width:double.infinity,
                      height:160,
                      fit:BoxFit.fill
                  )
              ),
              Container(
                padding: EdgeInsets.only(left:10,right:10,top:10),
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text('${_con.businessCardData.basicInformation.storeName} - ${widget.shopId}',
                          style: Theme.of(context).textTheme.headline3
                      )
                    ]
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:20,left:10,right:10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Icon(
                      Icons.access_time,size:16
                    ),
                    SizedBox(width:10),
                    Expanded(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                              Text (' ${_con.businessCardData.basicInformation.subtitle} ',maxLines: 1,style: Theme.of(context).textTheme.caption),



                          RichText(
                            text: TextSpan(text: S.of(context).timing,
                                style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.blue)),
                                children: [
                                  new TextSpan(
                                    text: (' ${_con.businessCardData.basicInformation.openingTime} - ${_con.businessCardData.basicInformation.openingTime}'),
                                    style: Theme.of(context).textTheme.caption

                                  )
                                ]),
                          ),
                        ],
                      )
                    ),
                    SizedBox(width:10),


                  ]
                )
              ),
              Container(
                  padding: EdgeInsets.only(top:10,left:10,right:10),
                  child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        Icon(
                            Icons.money,size:16
                        ),
                        SizedBox(width:10),
                        Expanded(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                RichText(
                                  text: TextSpan(text:  _con.businessCardData.basicInformation.mobile,
                                      style: Theme.of(context).textTheme.caption,
                                      children: [
                                        new TextSpan(
                                            text: '',
                                            style: Theme.of(context).textTheme.caption

                                        )
                                      ]),
                                ),
                              ],
                            )
                        ),


                      ]
                  )
              ),
              Container(
                  padding: EdgeInsets.only(top:10,left:10,right:10),
                  child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        Icon(
                            Icons.brunch_dining,size:16
                        ),
                        SizedBox(width:10),
                        Expanded(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                RichText(
                                  text: TextSpan(text: S.of(context).hoildays,
                                      style: Theme.of(context).textTheme.caption,
                                      children: [
                                        new TextSpan(
                                            text: (' ${_con.businessCardData.basicInformation.holidays.monVal?'Mon':''}'
                                                '${_con.businessCardData.basicInformation.holidays.tueVal?'Tue':''}'
                                                '${_con.businessCardData.basicInformation.holidays.wedVal?'Wed':''}'
                                                '${_con.businessCardData.basicInformation.holidays.thurVal?'Thur':''}'
                                                '${_con.businessCardData.basicInformation.holidays.friVal?'Fri':''}'
                                                '${_con.businessCardData.basicInformation.holidays.satVal?'Sat':''}'
                                                '${_con.businessCardData.basicInformation.holidays.sunVal?'Sun':''}'
                                                       ),
                                            style: Theme.of(context).textTheme.caption

                                        )
                                      ]),
                                ),
                              ],
                            )
                        ),


                      ]
                  )
              ),

              Container(
                  padding: EdgeInsets.only(top:20,left:10,right:10),
                  child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        Icon(
                            Icons.location_on_outlined,size:16
                        ),
                        SizedBox(width:10),
                        Expanded(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                RichText(
                                  text: TextSpan(text: 'Near to you ',
                                      style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.blue)),
                                      children: [
                                        new TextSpan(
                                            text: _con.businessCardData.basicInformation.pickupAddress,
                                            style: Theme.of(context).textTheme.caption

                                        )
                                      ]),
                                ),
                              ],
                            )
                        ),
                        SizedBox(width:10),
                       InkWell(
                          onTap: (){
                            _con.openMap( _con.businessCardData.basicInformation.latitude,  _con.businessCardData.basicInformation.longitude);
                          },
                          child: Align(
                              child:Icon(Icons.directions,size:18,color:Colors.red,)
                          ),
                        )

                      ]
                  )
              ),




             Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(top:40),
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  child:Column(children:[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:[
                        GestureDetector(
                          onTap: () async{
                            final url = _con.businessCardData.socialLinks.faceBook;
                            if (await canLaunch(url)) {
                            await launch(
                            url,
                            forceSafariVC: false,
                            );
                            }
                          },
                          child: Container(
                            height: 35,width:35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0,2),
                                      blurRadius: 6.0
                                  )
                                ],
                                image: DecorationImage(image: AssetImage('assets/img/facebook.png'),)
                            ),
                          ),
                        ),
                        SizedBox(width:30),
                        GestureDetector(
                          onTap: () async{
                            final url = _con.businessCardData.socialLinks.whatsApp;
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceSafariVC: false,
                              );
                            }
                          },
                          child: Container(
                            height: 35,width:35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0,2),
                                      blurRadius: 6.0
                                  )
                                ],
                                image: DecorationImage(image: AssetImage('assets/img/whatsap.png'),)
                            ),
                          ),
                        ),
                        SizedBox(width:30),
                        GestureDetector(
                          onTap: () async{
                            final url = _con.businessCardData.socialLinks.twitter;
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceSafariVC: false,
                              );
                            }
                          },
                          child: Container(
                            height: 35,width:35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0,2),
                                      blurRadius: 6.0
                                  )
                                ],
                                image: DecorationImage(image: AssetImage('assets/img/twitter.png'),)
                            ),
                          ),
                        ),
                        SizedBox(width:30),
                        GestureDetector(
                          onTap: () async{
                            final url = _con.businessCardData.socialLinks.instagram;
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceSafariVC: false,
                              );
                            }
                          },
                          child: Container(
                            height: 35,width:35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0,2),
                                      blurRadius: 6.0
                                  )
                                ],
                                image: DecorationImage(image: AssetImage('assets/img/google.png'),)
                            ),
                          ),
                        )  ,
                      ]
                  ),
                    SizedBox(height:20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        MaterialButton(
                          onPressed: () {
                            _con.addToFavorite(widget.shopId);
                          },
                          color:Theme.of(context).primaryColorDark,
                          minWidth: 200,
                          shape: StadiumBorder(),

                          height: 50,
                          padding: EdgeInsets.zero,
                          child:Wrap(
                            children:[
                              Icon(Icons.favorite_border,color:Theme.of(context).primaryColorLight),
                              Container(
                                  padding: EdgeInsets.only(top:3,left:10,right:5),
                                  child:Text( _con.checkMyShopList(widget.shopId)?'${S.of(context).remove_your_favourite}':'${S.of(context).add_to_favourite}',
                                      textAlign: TextAlign.center,
                                      style:TextStyle(fontFamily:'Futura-Book-Regular',fontWeight: FontWeight.w100,color: Theme.of(context).primaryColorLight)
                                  )
                              ),
                            ]
                          ),
                        )
                      ]
                    )

                  ])
                ),
              ),


            ],
          ),

        ),
        Positioned(
          top:-40,
          child: Container(
              margin: EdgeInsets.only(top:10),
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:Colors.white,
              ),


              height: 66,
              width:66,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child:Image.network(_con.businessCardData.preview, height: 66,width:66,
    fit: BoxFit.fill,)

              )


          ),
        ),

      ],
    );
  }
}
