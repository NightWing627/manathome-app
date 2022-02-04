import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:multisuperstore/src/models/shop_type.dart';
import 'package:multisuperstore/src/pages/send_package.dart';
import 'package:multisuperstore/src/pages/stores.dart';
import 'package:multisuperstore/src/pages/subcategory.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';

// ignore: must_be_immutable
class MyRecommendedTypeWidge extends StatefulWidget {
  List<ShopType> shopType;
  MyRecommendedTypeWidge({Key key, this.shopType});
  @override
  _MyRecommendedTypeWidgeState createState() => _MyRecommendedTypeWidgeState();
}

class _MyRecommendedTypeWidgeState extends State<MyRecommendedTypeWidge> {
  int intState = 7;
  bool openState = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.shopType.length,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.only(right: 10),
          itemBuilder: (context, index) {
            ShopType _shopTypeData = widget.shopType.elementAt(index);

            return Container(
                padding: EdgeInsets.only(
                  top: 15,
                  bottom: 12,
                  left: 12,
                ),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Column(children: [
                      GestureDetector(
                        onTap: () {
                          ShopType shopTypeData = ShopType();

                          currentRecommendation.value.removeWhere(
                              (item) => item.id == _shopTypeData.id);
                          if (currentRecommendation.value.length >= 7) {
                            currentRecommendation.value.remove(7);
                          } else {
                            shopTypeData.id = _shopTypeData.id;
                            shopTypeData.shopType = _shopTypeData.shopType;
                            shopTypeData.coverImage = _shopTypeData.coverImage;
                            shopTypeData.previewImage =
                                _shopTypeData.previewImage;
                            shopTypeData.title = _shopTypeData.title;
                            shopTypeData.homeShopType =
                                _shopTypeData.homeShopType;
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
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Stores(
                                storeType:
                                    int.parse(_shopTypeData.homeShopType),
                                pageTitle: _shopTypeData.title,
                                focusId: int.parse(_shopTypeData.id),
                                coverImage: _shopTypeData.coverImage,
                                previewImage: _shopTypeData.previewImage,
                              );
                            }));
                          }
                        },
                        child: Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        _shopTypeData.previewImage)))),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(
                          _shopTypeData.title,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.orange[900],
                              fontFamily: 'Futura-Book-Bold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                  ),
                ));
          }),
    );

    /* return Container(
      width:double.infinity,
      margin:EdgeInsets.only(left:5,right:5),
      padding: EdgeInsets.only(top:10),
      child: Wrap(
        children: List.generate(widget.shopType.length, (index) {
          ShopType _shopTypeData = widget.shopType.elementAt(index);
           return Wrap(
              children:[
              Container(
                    padding: EdgeInsets.only(bottom:10),
                    child:Column(
                        children:[
                        GestureDetector(
                        onTap: () {

                         if(_shopTypeData.shopType=='7'){
                            currentBookDetail.value.categoryName = _shopTypeData.title;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubCategory(id: _shopTypeData.id,)));
                          } else if(_shopTypeData.shopType=='2'){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendPackage()));
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return Stores(storeType: int.parse(_shopTypeData.shopType), pageTitle:  _shopTypeData.title,focusId: int.parse(_shopTypeData.id),
                                coverImage: _shopTypeData.coverImage,previewImage: _shopTypeData.previewImage,);
                            }));
                          }



                             },
                            child: Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(_shopTypeData.previewImage)
                                  )
                              )),
                        ),
                          SizedBox(height:5),
                          Container(
                            child: Text(
                              _shopTypeData.title,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ]
                    ),
                  ),


              ]
          );
        }),),
    );*/
  }
}
