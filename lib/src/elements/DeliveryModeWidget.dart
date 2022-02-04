// ignore: must_be_immutable

import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/vendor.dart';
import 'package:multisuperstore/src/repository/order_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';



// ignore: must_be_immutable
class DeliveryMode extends StatefulWidget {
   Vendor shopDetails;
   DeliveryMode({Key key, this.shopDetails,}) : super(key: key);
  @override
  _DeliveryModeState createState() => _DeliveryModeState();
}

class _DeliveryModeState extends State<DeliveryMode> {
  int selectedRadio;

  @override
  void initState() {
    super.initState();

    if(currentCheckout.value.deliverType!=0){
      selectedRadio = currentCheckout.value.deliverType;
    } else{
      selectedRadio = 1;
    }

  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      currentCheckout.value.deliverType = val;
    });
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: 1,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(top: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                return Container(
                  padding: EdgeInsets.only(right:10),
                  child: Column(
                    children: [
                      widget.shopDetails.instant?Div(
                        colS:12,
                        colM:12,
                        colL:12,
                        child:Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Radio(
                                    value: 1,
                                    groupValue: selectedRadio,
                                    activeColor: Colors.blue,
                                    onChanged: (val) {
                                      print("Radio $val");
                                      setSelectedRadio(val);
                                    }),
                                Expanded(
                                  child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Container(
                                          padding: EdgeInsets.only(top:10,),
                                          child: Text(S.of(context).instant_delivery,style: Theme.of(context).textTheme.bodyText1,),
                                        ),
                                        Container(
                                          child:Wrap(
                                              children:[
                                                Container(
                                                  padding: EdgeInsets.only(top:5,),
                                                  child:Icon(Icons.access_time,size:15),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top:5,left:4),
                                                  child: Text('${Helper.calculateTime(double.parse(widget.shopDetails.distance.replaceAll(',','')))}',style: Theme.of(context).textTheme.bodyText2,),
                                                ),
                                              ]
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top:7,),
                                          child: Text(S.of(context).the_order_will_be_delivered_to_you_at_your_shared_address_delivery_charges_will_apply,style: Theme.of(context).textTheme.caption,),
                                        ),



                                      ]
                                  ),
                                ),



                              ],
                            )
                          ],
                        ),
                      ):Container(),
                      SizedBox(height:10),
                      widget.shopDetails.takeaway?Div(
                        colS:12,
                        colM:12,
                        colL:12,
                        child:Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Radio(
                                    value: 3,
                                    groupValue: selectedRadio,
                                    activeColor: Colors.blue,
                                    onChanged: (val) {
                                      print("Radio $val");
                                      setSelectedRadio(val);
                                    }),
                                Expanded(
                                  child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Container(
                                          padding: EdgeInsets.only(top:10,),
                                          child: Text(S.of(context).takeaway,style: Theme.of(context).textTheme.bodyText1,),
                                        ),
                                        /*Container(
                                          child:Wrap(
                                              children:[
                                                Container(
                                                  padding: EdgeInsets.only(top:5,),
                                                  child:Icon(Icons.access_time,size:15),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top:5,left:4),
                                                  child: Text('${Helper.calculateTime(double.parse(widget.shopDetails.distance.replaceAll(',','')))}',style: Theme.of(context).textTheme.bodyText2,),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top:5,left:15),
                                                  child:Icon(Icons.electric_bike_outlined,size:15),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top:5,left:4),
                                                  child: Text('',style: Theme.of(context).textTheme.bodyText2,),
                                                ),

                                              ]
                                          ),
                                        ),*/
                                        Container(
                                          padding: EdgeInsets.only(top:7,),
                                          child: Text(S.of(context).you_will_have_to_pick_up_the_order_yourself_from_the_restaurant_the_order_wont_be_delivered_to_your_location

                                            ,style: Theme.of(context).textTheme.caption,),
                                        ),



                                      ]
                                  ),
                                ),



                              ],
                            )
                          ],
                        ),
                      ):Container(),
                      SizedBox(height:10),
                      widget.shopDetails.schedule?Div(
                        colS:12,
                        colM:12,
                        colL:12,
                        child:Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Radio(
                                    value: 2,
                                    groupValue: selectedRadio,
                                    activeColor: Colors.blue,
                                    onChanged: (val) {
                                      print("Radio $val");
                                      setSelectedRadio(val);
                                    }),
                                Expanded(
                                  child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Container(
                                          padding: EdgeInsets.only(top:10,),
                                          child: Text(S.of(context).scheduled_delivery,style: Theme.of(context).textTheme.bodyText1,),
                                        ),
                                        Container(
                                          child:Wrap(
                                              children:[
                                                /**Container(
                                                  padding: EdgeInsets.only(top:5,),
                                                  child:Icon(Icons.access_time,size:15),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top:5,left:4),
                                                  child: Text('',style: Theme.of(context).textTheme.bodyText2,),
                                                ), */
                                                Container(
                                                  padding: EdgeInsets.only(top:5,),
                                                  child:Icon(Icons.directions_car,size:15),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top:5,left:4),
                                                  child: Text(Helper.priceDistance(widget.shopDetails.distance),style: Theme.of(context).textTheme.bodyText2,),
                                                ),

                                              ]
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top:7,),
                                          child: Text('The order will be delivered to you at your shared address at scheduled time'

                                            ,style: Theme.of(context).textTheme.caption,),
                                        ),



                                      ]
                                  ),
                                ),



                              ],
                            )
                          ],
                        ),
                      ):Container(),

                    ],
                  ),
                );

              }, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 5);
            },),


          ])),

    ]);
  }
}