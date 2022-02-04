import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../elements/Productbox2Widget.dart';
import 'product_details2.dart';
import '../controllers/product_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


// ignore: must_be_immutable
class CategorySwipeHeader extends StatefulWidget {
  final List<ProductDetails2> productData;

  CategorySwipeHeader({Key key, this.productData,this.con, this.shopId, this.shopName, this.subtitle, this.km, this.shopTypeID, this.longitude, this.latitude, this.callback, this.focusId}) : super(key: key);
  ProductController con;
  String shopId;
  String shopName;
  String subtitle;
  String km;
  int shopTypeID;
  String latitude;
  String longitude;
  Function callback;
  int focusId;
  @override
  _CategorySwipeHeaderState createState() => _CategorySwipeHeaderState();
}

class _CategorySwipeHeaderState extends StateMVC<CategorySwipeHeader> {

  @override
  // ignore: must_call_super
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.productData.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16, right: 2),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ProductBox2Widget(choice: widget.productData[index], con: widget.con,shopId: widget.shopId,shopName: widget.shopName, subtitle: widget.subtitle,km: widget.km,shopTypeID: widget.shopTypeID,latitude: widget.latitude,longitude: widget.longitude,callback: widget.callback,focusId: widget.focusId, );
      },
    );
  }
}
