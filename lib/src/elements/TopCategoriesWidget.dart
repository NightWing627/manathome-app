import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/category_product.dart';
import '../models/category.dart';
import 'CategoryLoaderWidget.dart';


// ignore: must_be_immutable
class TopCategoriesWidget extends StatefulWidget {
  List<Category> categoryData;
  String shopId;
  String shopName;
  String subtitle;
  String km;
  int shopTypeID;
  String longitude;
  String latitude;
  int focusId;
  TopCategoriesWidget({Key key, this.categoryData, this.shopId, this.shopName, this.subtitle, this.km, this.shopTypeID, this.latitude, this.longitude, this.focusId}) : super(key: key);
  @override
  _TopCategoriesWidgetState createState() => _TopCategoriesWidgetState();
}

class _TopCategoriesWidgetState extends State<TopCategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return   widget.categoryData.isEmpty? CategoryLoaderWidget() :GridView.builder(
        itemCount: widget.categoryData.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10.0, crossAxisCount: (Orientation.portrait == MediaQuery.of(context).orientation) ? 3 : 3),
        itemBuilder: (context, index) {
          Category _categoryData = widget.categoryData.elementAt(index);
          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: new InkResponse(
                onTap: () {

                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryProduct(categoryData: _categoryData,shopId: widget.shopId, shopName: widget.shopName, subtitle: widget.subtitle,km:widget.km ,shopTypeID: widget.shopTypeID, latitude: widget.latitude, longitude: widget.longitude,focusId: widget.focusId,  )));

                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),

                        ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10,bottom: 5),
                              child: Container(
                                height: 80.0,
                                width: 70.0,
                                child: Image(
                                  image: NetworkImage(
                                    _categoryData.image,
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                            padding: EdgeInsets.only(top: 4, right: 5, left: 5, bottom: 4),
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(child: Text(_categoryData.name, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText2))
                              ],
                            )),
                      )
                    ]))),
          );
        });
  }
}
