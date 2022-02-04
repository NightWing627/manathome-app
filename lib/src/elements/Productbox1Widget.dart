import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product_details2.dart';
import '../controllers/product_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'RestaurantProductBox.dart';

// ignore: must_be_immutable
class ProductBox1Widget extends StatefulWidget {
  final List<ProductDetails2> productData;

  String shopId;
  String shopName;
  String subtitle;
  String km;
  int shopTypeID;
  String latitude;
  String longitude;
  Function callback;
  int focusId;
  ProductBox1Widget({Key key, this.productData, this.shopId, this.shopName, this.subtitle, this.km, this.shopTypeID, this.latitude, this.longitude, this.callback, this.focusId}) : super(key: key);
  @override
  _ProductBox1WidgetState createState() => _ProductBox1WidgetState();
}

class _ProductBox1WidgetState extends StateMVC<ProductBox1Widget> {
  ProductController _con;

  _ProductBox1WidgetState() : super(ProductController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.productData.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16, right: 2),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return RestaurantProductBox(choice: widget.productData[index], con: _con,shopId: widget.shopId,shopName: widget.shopName,subtitle: widget.subtitle,km: widget.km, shopTypeID: widget.shopTypeID,longitude: widget.longitude,latitude: widget.latitude,callback: widget.callback,focusId: widget.focusId,);
      },
    );
  }
}


