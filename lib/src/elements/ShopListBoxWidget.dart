import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/RectangularLoaderWidget.dart';
import 'package:multisuperstore/src/models/shop_type.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/vendor_controller.dart';
import '../Widget/custom_divider_view.dart';
import 'NoShopFoundWidget.dart';
import 'ShopListWidget.dart';

// ignore: must_be_immutable
class ShopListBoxWidget extends StatefulWidget {
  VendorController con;
  String pageTitle;
  int shopType;
  int focusId;
  String previewImage;
  ShopListBoxWidget(
      {Key key,
      this.con,
      this.pageTitle,
      this.shopType,
      this.focusId,
      this.previewImage})
      : super(key: key);
  @override
  _ShopListBoxWidgetState createState() => _ShopListBoxWidgetState();
}

class _ShopListBoxWidgetState extends StateMVC<ShopListBoxWidget> {
  bool ratingOne = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.con.vendorList.isEmpty
        ? RectangularLoaderWidget()
        : Container(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.con.vendorList.length,
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return ShopList(
                        choice: widget.con.vendorList[index],
                        shopType: widget.shopType,
                        focusId: widget.focusId,
                        previewImage: widget.previewImage,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 0);
                    },
                  ),
                  SizedBox(height: 50)
                ])),
          );
  }
}
