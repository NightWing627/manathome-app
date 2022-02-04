import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/controllers/home_controller.dart';
import 'package:multisuperstore/src/controllers/vendor_controller.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'RectangleLoaderWidget.dart';
import 'ShopListWidget.dart';
// ignore: must_be_immutable
class SpotlightWidget extends StatefulWidget {

  HomeController con;
  SpotlightWidget({Key key,this.con});
  @override
  _SpotlightWidgetState createState() => _SpotlightWidgetState();
}

class _SpotlightWidgetState extends StateMVC<SpotlightWidget> {
  VendorController _con;

  _SpotlightWidgetState() : super(VendorController()) {
    _con = controller;
  }
  int shopType;
  int focusId;
  String previewImage;
  int i= 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentRecommendation.value.forEach((element) {
      if(element.homeShopType!=null){
      if(element.shopType!='7' && element.shopType!='2') {

        if (i == 1) {
          shopType = int.parse(element.homeShopType);
          focusId = int.parse(element.id);
          previewImage = element.previewImage;
          i++;
        }}
      }
    });
    _con.listenForVendorList(shopType,focusId);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),

      child:
      _con.vendorList.isEmpty?RectangleLoaderWidget(): ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: _con.vendorList.length,
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(top: 16),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, int index) {
              return ShopList(choice: _con.vendorList[index], shopType: shopType,focusId: focusId,previewImage:previewImage,);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 0);
            },
          ),

    );
  }
}

