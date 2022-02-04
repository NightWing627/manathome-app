import '../helpers/custom_trace.dart';
import 'addon.dart';

class CartResponce {
  String id;
  // ignore: non_constant_identifier_names
  String product_name;
  String price;
  String strike;
  int offer;
  String quantity;
  int qty;
  String variant;
  String variantValue;
  String userId;
  String cartId;
  String unit;
  String shopId;
  String image;
  double tax;
  String discount;
  List<AddonModel> addon = <AddonModel>[];

  CartResponce();

  CartResponce.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      product_name = jsonMap['product_name']!=null ?jsonMap['product_name']:'';
      price = jsonMap['price'] !=null ?jsonMap['price']:'';
      strike = jsonMap['strike'] !=null ?jsonMap['strike']:'';
      offer = jsonMap['offer'] !=null ?jsonMap['offer']:0;
      quantity = jsonMap['quantity'] !=null ?jsonMap['quantity']:'';
      qty = jsonMap['qty'] !=null ?jsonMap['qty']:0;
      userId = jsonMap['userId'] !=null ?jsonMap['userId']:'';
      cartId = jsonMap['cartId'] !=null ?jsonMap['cartId']:'';
      variant = jsonMap['variant'] !=null ?jsonMap['variant']:'';
      variantValue = jsonMap['variantValue'] !=null ?jsonMap['variantValue']:'';
      unit = jsonMap['unit'] !=null ?jsonMap['unit']:'';
      shopId = jsonMap['shopId'] !=null ?jsonMap['shopId']:'';
      image = jsonMap['image'] !=null ?jsonMap['image']:'';
      tax =  jsonMap['tax'].toDouble()!= null ? jsonMap['tax'].toDouble() :  0.0;
      discount = jsonMap['discount'] !=null ?jsonMap['discount']:'';
      addon = jsonMap['addon'] != null ? List.from(jsonMap['addon']).map((element) => AddonModel.fromJSON(element)).toList() : [];

    } catch (e) {
      id = '';
      product_name = '';
      price = '';
      strike = '';
      offer = 0;
      quantity ='';
      qty = 1;
      userId = '';
      cartId = '';
      variant = '';
      variantValue = '';
      unit = '';
      shopId = '';
      addon = [];
      image = '';
      discount = '';
      tax = 1;
      print(e);
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": product_name,
    "price": price,
    "strike": strike,
    "offer": offer,
    "qty": qty,
    "quantity": quantity,
    "variant": variant,
    "variantValue": variantValue,
    "userId": userId,
    "cartId": cartId,
    "unit": unit,
    "shopId": shopId,
    "image": image,
    "tax": tax,
    "discount": discount,
  };

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["product_name"] = product_name;
    map["price"] = price;
    map["strike"] = strike;
    map["offer"] = offer;
    map["quantity"] = quantity;
    map["qty"] = qty;
    map["variant"] = variant;
    map["variantValue"] = variantValue;
    map["userId"] = userId;
    map["cartId"] = cartId;
    map["unit"] = unit;
    map["shopId"] = shopId;
    map["image"] = image;
    map["tax"] = tax;
    map["discount"] = discount;
    map["addon"] = addon?.map((element) => element.toMap())?.toList();
    return map;
  }
}
