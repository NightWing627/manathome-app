import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:multisuperstore/src/models/shop_type.dart';
import 'package:multisuperstore/src/pages/booking_detail_service.dart';
import 'package:multisuperstore/src/pages/send_package.dart';
import 'package:multisuperstore/src/pages/stores.dart';
import 'package:multisuperstore/src/pages/subcategory.dart';
import 'package:multisuperstore/src/pages/table_reservation_service.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class CategoryShopType extends StatefulWidget {
  List<ShopType> shopType;
  int shopTypeStatic;
  CategoryShopType({Key key, this.shopType, this.shopTypeStatic = 2});
  @override
  _CategoryShopTypeState createState() => _CategoryShopTypeState();
}

class _CategoryShopTypeState extends State<CategoryShopType> {
  int intState = 7;

  bool openState = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      margin: EdgeInsets.only(left: 0, right: 0),
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
          viewportFraction: 0.45,
          itemWidth: 200,
          scrollDirection: Axis.horizontal,
          scale: 0.7,
          fade: 0.2,
          itemCount: widget.shopType.length,
          itemBuilder: (_, index) {
            ShopType _shopTypeData = widget.shopType.elementAt(index);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(children: [
                GestureDetector(
                  onTap: () {
                    ShopType shopTypeData = ShopType();

                    currentRecommendation.value
                        .removeWhere((item) => item.id == _shopTypeData.id);
                    if (currentRecommendation.value.length >= 7) {
                      currentRecommendation.value.remove(7);
                    } else {
                      shopTypeData.id = _shopTypeData.id;
                      shopTypeData.shopType = _shopTypeData.shopType;
                      shopTypeData.coverImage = _shopTypeData.coverImage;
                      shopTypeData.previewImage = _shopTypeData.previewImage;
                      shopTypeData.title = _shopTypeData.title;
                      shopTypeData.homeShopType = _shopTypeData.homeShopType;
                    }

                    currentRecommendation.value.insert(0, shopTypeData);
                    if (_shopTypeData.shopType == '7') {
                      currentBookDetail.value.categoryName =
                          _shopTypeData.title;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SubCategory(
                                id: _shopTypeData.id,
                              )));
                    } else if (_shopTypeData.shopType == '2') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SendPackage()));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Stores(
                          storeType: widget
                              .shopTypeStatic, //int.parse(widget.shopType[index].shopType),
                          pageTitle: _shopTypeData.title,
                          focusId: int.parse(_shopTypeData.id),
                          coverImage: _shopTypeData.coverImage,
                          previewImage: _shopTypeData.previewImage,
                        );
                      }));
                    }
                  },
                  child: Container(
                    width: 200.0,
                    height: 130.0,
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 2),
                      borderRadius: BorderRadius.circular(10),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(_shopTypeData.coverImage),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  child: Text(
                    _shopTypeData.title.toUpperCase(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.orange[900],
                        fontSize: 13,
                        fontFamily: 'Futura-Book-Bold',
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ]),
            );
          }),
    );
  }
}
