import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/product_controller.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/product_details2.dart';
import 'package:multisuperstore/src/models/variant.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


import 'ClearCartWidget.dart';
import 'Productbox2Widget.dart';
import 'ProductsCarouselLoaderWidget.dart';
// ignore: must_be_immutable
class AddCartSliderWidget extends StatefulWidget {
  List<ProductDetails2> productList;
  final String shopId;
  final String shopName;
  final String subtitle;
  final String km;
  final int shopTypeID;
  final String latitude;
  final String longitude;
  Function callback;
  final int focusId;
  AddCartSliderWidget({Key key, this.productList,this.shopId, this.shopName, this.subtitle, this.km, this.shopTypeID
    ,this.latitude, this.longitude, this.callback, this.focusId}) : super(key: key);

  bool loader;
  @override
  _AddCartSliderWidgetState createState() => _AddCartSliderWidgetState();
}

class _AddCartSliderWidgetState extends StateMVC<AddCartSliderWidget> {

  ProductController _con;
  _AddCartSliderWidgetState() : super(ProductController()) {
    _con = controller;

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  widget.productList.isEmpty
        ? ProductsCarouselLoaderWidget()
        :ListView.builder(
        shrinkWrap: true,
        itemCount: widget.productList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          ProductDetails2 _productDetails = widget.productList.elementAt(index);
          return Stack(
              children:[
                Container(
                    padding: EdgeInsets.only(left:10),
                    child: Column(
                        children: List<Widget>.generate(_productDetails.variant.length, (index) {
                          variantModel _variantData = _productDetails.variant.elementAt(index);
                          return _variantData.selected ? Row(
                              children: [
                          Expanded(
                          child:Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.bottomCenter,
                                        children: [

                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: Stack(
                                                children:[
                                                  Container(
                                                    decoration: new BoxDecoration(
                                                      border: Border.all(color: Colors.orange, width: 2),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child:
                                                    ColorFiltered(
                                                      colorFilter: ColorFilter.mode(
                                                        Colors.transparent, // 0 = Colored, 1 = Black & White
                                                        BlendMode.saturation,
                                                      ),
                                                      child:ClipRRect(
                                                          borderRadius: BorderRadius.circular(0),
                                                          child: _variantData.image!='no_image'?CachedNetworkImage(
                                                            imageUrl: _variantData.image,
                                                            placeholder: (context, url) => new CircularProgressIndicator(),
                                                            errorWidget: (context, url, error) => new Icon(Icons.error),
                                                            fit: BoxFit.cover,
                                                            width: MediaQuery.of(context).size.width * 0.2,
                                                            height: MediaQuery.of(context).size.width * 0.28,
                                                          ):CachedNetworkImage(
                                                            imageUrl: _variantData.image,
                                                            placeholder: (context, url) => new CircularProgressIndicator(),
                                                            errorWidget: (context, url, error) => new Icon(Icons.error),
                                                            fit: BoxFit.cover,
                                                            width: MediaQuery.of(context).size.width * 0.2,
                                                            height: MediaQuery.of(context).size.width * 0.28,
                                                          )),
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ],
                                      ),

                                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                                        Container(
                                            padding: EdgeInsets.only(left: 10, right: 10, top: 4,),
                                            child: Text(_productDetails.product_name,
                                              maxLines: 1,
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 15),
                                            )
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 5, right: 10, ),
                                          child:InkWell(
                                            onTap: (){
                                              AvailableQuantityHelper.exit(context,_productDetails.variant, _productDetails.product_name, _variantData.selected).then((receivedLocation) {

                                                if(receivedLocation!=null) {
                                                  _productDetails.variant.forEach((_l) {
                                                    setState(() {
                                                      if (_l.variant_id == receivedLocation) {
                                                        _l.selected = true;
                                                      } else {
                                                        _l.selected = false;
                                                      }
                                                    });
                                                  });
                                                }
                                              });
                                            },
                                            child:Container(
                                                height:30,
                                                width:110,
                                                padding:EdgeInsets.all(5),

                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('${_variantData.quantity}${_variantData.unit}',

                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: 12),),
                                                    Icon(Icons.arrow_drop_down,size:19,color:Colors.grey)
                                                  ],
                                                )),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          padding: EdgeInsets.only(left: 10, right: 10, ),
                                          child:Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children:[
                                                Container(
                                                  width:size.width < 320 ? size.width * 0.47 :size.width * 0.50,
                                                  child:Text(  Helper.pricePrint(_variantData.sale_price),
                                                    overflow: TextOverflow.ellipsis, maxLines: 1,
                                                    style: Theme.of(context).textTheme.headline1.merge(TextStyle(fontWeight: FontWeight.w700)),
                                                  ),
                                                ),


                                                1 ==  _con.checkProductIdCartVariant(_productDetails.id,_variantData.variant_id)
                                                    ?  InkWell(
                                                    onTap: (){
                                                      _con.checkShopAdded(_productDetails, 'cart',_variantData, widget.shopId,ClearCartShow, widget.shopName, widget.subtitle, widget.km, widget.shopTypeID, widget.latitude, widget.longitude, widget.callback, widget.focusId);
                                                    },
                                                    child:Padding(
                                                      padding: EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 0),
                                                      child: Container(
                                                          alignment: Alignment.centerRight,
                                                          height: 55,
                                                          width: 55,
                                                          /*width: MediaQuery.of(context).size.width * 0.25,*/
                                                          child: Image.asset('assets/img/ic_carrello.png')),
                                                    )
                                                )
                                                    : InkWell(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left:5,

                                                    ),
                                                    child: Wrap(
                                                        alignment: WrapAlignment.spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                _con.decrementQtyVariant(
                                                                    _productDetails.id, _variantData.variant_id
                                                                );
                                                              });
                                                            },

                                                            child: Icon(Icons.remove_circle,color:Theme.of(context).backgroundColor,size:27),

                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(context).size.width *  0.01,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(top: 5),
                                                            child: Text( _con.showQtyVariant(_productDetails.id, _variantData.variant_id), style: Theme.of(context).textTheme.bodyText1),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(context).size.width *  0.01,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                _con.incrementQtyVariant(_productDetails.id,_variantData.variant_id);
                                                              });
                                                            },

                                                            child: Icon(Icons.add_circle,color:Theme.of(context).backgroundColor,size:27),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),)
                              ]
                          ): Container(); }   ))

                )
              ]
          );

        }
    );
  }
  // ignore: non_constant_identifier_names
  void ClearCartShow() {
    var size = MediaQuery.of(context)
        .size;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: size.height * 0.3,
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
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left:size.width * 0.05,right:size.width * 0.05),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClearCart(),
                            ]),
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
                              /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
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
                              /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {

                                _con.clearCart();
                              },
                              child: Center(
                                  child: Text(
                                    S.of(context).clear_cart,
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
}


