import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import '../controllers/logistics_controller.dart';
import '../elements/package_card.dart';
import '../elements/timeline.dart';
import '../models/Dropdown.dart';
import '../repository/user_repository.dart';

import 'Widget/custom_divider_view.dart';



class SendPackage extends StatefulWidget {
  @override
  _SendPackageState createState() => _SendPackageState();
}

class _SendPackageState extends StateMVC<SendPackage> {
  LogisticsController _con;


  _SendPackageState() : super(LogisticsController()) {
    _con = controller;

  }
  int dropDownValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.pickupAddressController.text = currentUser.value.selected_address;
    _con.listenForItem();
    _con.sendPackageData.itemName = 'Please select your item';

  }
  // ignore: non_constant_identifier_names
  void ItemList() {
    var size = MediaQuery.of(context)
        .size;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: size.height * 0.64,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom:5,top:15),
                        height: 3,
                        width:40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: Color(0xffd9dbdb)),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left:size.width * 0.05,right:size.width * 0.05),
                    child: Image(image:AssetImage('assets/img/package.png'),
                      width:50,height:60,
                    ),

                  ),
                  Container(

                    padding: EdgeInsets.only(left:size.width * 0.05,right:size.width * 0.05),
                    child: GestureDetector(
                      onTap: () {

                      },
                      child:Text('Select Package Content',style:Theme.of(context).textTheme.headline1),),
            ),
                  SizedBox(height: 5,),
                  Expanded(
                    child: Container(

                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0)),
                      ),

                        child:ListView(
                            children: List.generate(_con.ListData.length, (index){
                              DropDownModel _dropData = _con.ListData.elementAt(index);
                              return SelectPackage(con:_con,itemDetails: _dropData,);
                            })
                        ),



                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left:size.width * 0.05,right:size.width * 0.05,top: 5, bottom: 5),
                      child:Row(
                        children: [
                          Container(
                            width: size.width * 0.44,
                            height: 45.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Colors.grey[200],
                                    width:1
                                )

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
                          SizedBox(width:size.width * 0.02),
                          Container(
                            width: size.width * 0.44,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(30),

                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {

                              },
                              child: Center(
                                  child: Text(
                                    S.of(context).done,
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








  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,

            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon:Icon(Icons.arrow_back_ios)),
            actions: [
              IconButton(
                onPressed:(){

                },
                icon: Icon(Icons.help_outline,color:Colors.blue),
              )


            ],
            title: Text(
              S.of(context).send_package,
              style: Theme.of(context).textTheme.headline1,
            )),
        body: Container(
          color:Theme.of(context).primaryColor,
          child:Column(
            children: [
              Expanded(
                  child:SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PackageCard(slides: _con.slides),
                        Timeline(
                          indicatorSize:22,
                          lineColor: Colors.grey[400],
                          padding: EdgeInsets.only(left:15,right:15),
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(left:10,right:10),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,

                                            controller:  _con.pickupAddressController,

                                            onTap: () async{


                                              /*Navigator.of(context).pushNamed('/Login');*/
                                              /** LocationResult result = await showLocationPicker(
                                                context,
                                                setting.value.googleMapsKey,
                                                initialCenter: LatLng(31.1975844, 29.9598339),
                                                automaticallyAnimateToCurrentLocation: true,
                                                myLocationButtonEnabled: true,
                                                layersButtonEnabled: true,
                                                resultCardAlignment: Alignment.bottomCenter,
                                              );

                                              _addressData.latitude = result.latLng.latitude;
                                              _addressData.longitude = result.latLng.longitude;
                                              _addressData.addressSelect = result.address;
                                              _addressData.isDefault = 'false';
                                              setState(() {
                                                _con.pickupAddressController.text = _addressData.addressSelect;
                                              });

                                              _con.sendPackageData.pickupAddress = _addressData; */

                                            },
                                            style: Theme.of(context).textTheme.bodyText1,
                                            decoration: InputDecoration(
                                              labelText: 'Pickup Address',
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

                                  ],
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(left:10,right:10),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            controller: _con.deliveryAddressController,
                                            onTap: () async{


                                              /*Navigator.of(context).pushNamed('/Login');*/
                                             /** LocationResult result = await showLocationPicker(
                                                context,
                                                setting.value.googleMapsKey,
                                                initialCenter: LatLng(31.1975844, 29.9598339),
                                                automaticallyAnimateToCurrentLocation: true,
                                                myLocationButtonEnabled: true,
                                                layersButtonEnabled: true,
                                                resultCardAlignment: Alignment.bottomCenter,
                                              );

                                              _addressData.latitude = result.latLng.latitude;
                                              _addressData.longitude = result.latLng.longitude;
                                              _addressData.addressSelect = result.address;
                                              _addressData.isDefault = 'false';
                                              setState(() {
                                                _con.deliveryAddressController.text = _addressData.addressSelect;
                                              });

                                              _con.sendPackageData.deliveryAddress = _addressData; */

                                            },
                                            keyboardType: TextInputType.text,
                                            style: Theme.of(context).textTheme.bodyText1,
                                            decoration: InputDecoration(
                                              labelText: 'Delivery Address',
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

                                  ],
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(top:18,left:10,right:10),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Select Package Content',style:Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .merge(TextStyle(color: Colors.grey)),),
                                    SizedBox(height:5),
                               _con.ListData.isEmpty?  Text('Loading',style:Theme.of(context).textTheme.subtitle2):GestureDetector(
                                  onTap: () {
                                    ItemList();
                                  },
                                  child: Text(_con.sendPackageData.itemName,style:Theme.of(context).textTheme.subtitle2),
                                ),
                                    SizedBox(height:10),
                                    CustomDividerView(dividerHeight: 2,),
                                  ],
                                )
                            ),

                          ],
                          indicators: <Widget>[
                            Container(

                                decoration:BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border:Border.all(
                                      width: 3,
                                      color:Colors.grey[300]
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                )
                            ),
                            Container(

                                decoration:BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border:Border.all(
                                      width: 3,
                                      color:Colors.grey[300]
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                )
                            ),
                            Container(

                              decoration:BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.secondary,
                                border:Border.all(
                                    width: 3,
                                    color:Colors.white54
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Icon(Icons.check,color: Colors.white,size:15),
                            ),



                          ],
                        ),
                        SizedBox(height:20),
                        CustomDividerView(dividerHeight: 3,),
                        Padding(
                          padding:EdgeInsets.only(top:10,bottom:50,left:10,right:25),
                          child:Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 30,right:10,left:5),
                                child: Container(
                                  child: Icon(Icons.edit,size:25),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top:14),
                                    width: double.infinity,
                                    child: TextFormField(
                                        textAlign: TextAlign.left,
                                        autocorrect: true,
                                        onSaved: (input) => _con.sendPackageData.message = input,
                                        keyboardType: TextInputType.text,
                                        style: Theme.of(context).textTheme.bodyText1,
                                        decoration: InputDecoration(
                                          //labelText: 'Address',
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
                              ),



                            ],
                          ),
                        ),
                        CustomDividerView(dividerHeight: 3,),
                        Padding(
                          padding:EdgeInsets.only(top:10,bottom:10,left:20,right:20),
                          child:Wrap(
                              children:[
                                Text('A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea.',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                                Text('Terms & Conditions',style:TextStyle(color:Colors.blue))
                              ]
                          ),
                        ),
                        CustomDividerView(dividerHeight: 3,),
                      ],
                    ),
                  )
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: [

                    SizedBox(height:10),
                    InkWell(
                        onTap: () {},
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          padding:EdgeInsets.only(left:20,right:20),
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
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
                                Toast.show('Demo version',context,  gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
                              },
                              child: Center(
                                  child: Text(
                                    S.of(context).confirm_order,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ),
                          ),
                        ))
                  ],
                ),),
            ],
          ),
        ));
  }
}





// ignore: must_be_immutable
class SelectPackage extends StatefulWidget {
  SelectPackage({Key key, this.con, this.itemDetails}) : super(key: key);
  DropDownModel itemDetails;
  LogisticsController con;
  @override
  _SelectPackageState createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectPackage> {



  int checkedItem = 0;


  @override
  Widget build(BuildContext context) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
                padding: const EdgeInsets.only(top:10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ListTile(
                        leading:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Wrap(
                              children: [
                                Checkbox(
                                  value: widget.itemDetails.isSelected,
                                  onChanged: (bool value) {

                                    /// manage the state of each value
                                    setState(() {
                                      if(widget.itemDetails.isSelected==true) {
                                        widget.itemDetails.isSelected = false;
                                        widget.con.sendPackageData.itemName ='';
                                      }else{
                                        widget.itemDetails.isSelected = true;
                                        widget.con.sendPackageData.itemName = widget.itemDetails.name;
                                      }
                                    });
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top:13),
                                  child: Text(widget.itemDetails.name,style:Theme.of(context).textTheme.bodyText1),
                                ),

                              ],
                            )
                          ],
                        )
                      ),









                    ]
                )
            ),
          ),
















        ]);
  }
}




