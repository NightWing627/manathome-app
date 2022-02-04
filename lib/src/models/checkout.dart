import 'address.dart';
import 'payment.dart';
import '../helpers/custom_trace.dart';
import 'cart_responce.dart';

class Checkout {
  String id;
  List<CartResponce> cart = <CartResponce>[];
  Address address = new Address();
  Payment payment = new Payment();
  // ignore: non_constant_identifier_names
  double grand_total = 0.0;
  double discount = 0.0;
  // ignore: non_constant_identifier_names
  double sub_total = 0.0;
  double tax = 0.0;
  String userId;
  String saleCode;
  String couponCode;
  bool couponStatus = false;
  String deliveryTimeSlot;
  String deliveryTime;
  String shopId;
  String shopName;
  String shopImage;
  String subtitle;
  int shopTypeID = 0;
  double km = 0.0;
  // ignore: non_constant_identifier_names
  double delivery_fees = 0;
  // ignore: non_constant_identifier_names
  double delivery_tips =0;
  String shopLatitude;
  String shopLongitude;
  int deliverType;
  int focusId;
  bool deliveryPossible = false;
  var uploadImage ;





  Checkout();

  Checkout.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      cart = jsonMap['cart'] != null ? List.from(jsonMap['cart']).map((element) => CartResponce.fromJSON(element)).toList() : [];

      address = jsonMap['address'] != null ? Address.fromJSON(jsonMap['address']) : Address.fromJSON({});
      payment = jsonMap['payment'] != null ? Payment.fromJSON(jsonMap['payment']) : Payment.fromJSON({});
      grand_total = jsonMap['grand_total'] != null ? jsonMap['grand_total'].toDouble() : 0;
      tax = jsonMap['tax'] != null ? jsonMap['tax'].toDouble() : 0;
      discount = jsonMap['discount']!= null ? jsonMap['discount'] : '';
      sub_total = jsonMap['sub_total']!= null ? jsonMap['sub_total'] : '';
      userId = jsonMap['userID']!= null ? jsonMap['userID'] : '';
      saleCode = jsonMap['saleCode']!= null ? jsonMap['saleCode'] : '';
      couponCode = jsonMap['couponCode'];
      couponStatus = jsonMap['couponStatus'];
      deliveryTimeSlot = jsonMap['deliveryTimeSlot'];
      deliveryTime = jsonMap['deliveryTime'];
      shopId = jsonMap['shopId'];
      shopName = jsonMap['shopName'];
      subtitle = jsonMap['subtitle'];
      shopImage = jsonMap['shopImage'];
      shopTypeID = jsonMap['shopTypeID'];
      km = jsonMap['km'];
      delivery_fees = jsonMap['delivery_fees'];
      delivery_tips = jsonMap['delivery_tips'];
      shopLatitude = jsonMap['shopLatitude'];
      shopLongitude = jsonMap['shopLongitude'];
      deliverType = jsonMap['deliverType'];
      focusId = jsonMap['focusId']!= null ? jsonMap['focusId'] : '';
      deliveryPossible = jsonMap['deliveryPossible']!=null?jsonMap['deliveryPossible']:false;
      uploadImage = jsonMap['uploadImage'];

    } catch (e) {
      id = '';
      grand_total = 0;
      tax = 0;
      cart = [];
      address = Address.fromJSON({});
      payment = Payment.fromJSON({});
      userId = '';
      saleCode = '';
      couponCode = '';
      couponStatus = false;
      deliveryTimeSlot = '';
      deliveryTime = '';
      shopId = null;
      shopImage = '';
      subtitle = '';
      km =0.0;
      delivery_fees = 0;
      delivery_tips = 0;
      shopLatitude = '';
      shopLongitude = '';
      deliverType = 0;
      focusId = 0;
      uploadImage ='';
      deliveryPossible = false;
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "tax": tax,
    "cart": cart?.map((element) => element.toMap())?.toList(),
    "address": address.toMap(),
    "payment": payment.toMap(),
    "grand_total": grand_total,
    "sub_total": sub_total,
    "discount": discount,
    "userId": userId,
    "saleCode": saleCode,
    "couponCode": couponCode,
    "couponStatus": couponStatus,
    "deliveryTimeSlot": deliveryTimeSlot,
    "deliveryTime": deliveryTime,
    "shopId": shopId,
    "shopName": shopName,
    "shopImage": shopImage,
    "km": km,
    "subtitle": subtitle,
    "delivery_fees": delivery_fees,
    "delivery_tips": delivery_tips,
    "deliverType": deliverType,
    "focusId": focusId,
    "deliveryPossible" : deliveryPossible,
    "uploadImage": uploadImage
  };


  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["tax"] = tax;
    map["cart"] = cart?.map((element) => element.toMap())?.toList();
    map["address"] = address.toMap();
    map["payment"] = payment.toMap();
    map["grand_total"] = grand_total;
    map["sub_total"] = sub_total;
    map["discount"] = discount;
    map["userId"] = userId;
    map["saleCode"] = saleCode;
    map["couponCode"] = couponCode;
    map["couponStatus"] = couponStatus;
    map["deliveryTimeSlot"] = deliveryTimeSlot;
    map["deliveryTime"] = deliveryTime;
    map["shopId"] = shopId;
    map["shopName"] = shopName;
    map["shopImage"] = shopImage;
    map["shopTypeID"] = shopTypeID;
    map["km"] = km;
    map["subtitle"] = subtitle;
    map["delivery_fees"] = delivery_fees;
    map["delivery_tips"] = delivery_tips;
    map["shopLatitude"] = shopLatitude;
    map["shopLongitude"] = shopLongitude;
    map["deliverType"] = deliverType;
    map["focusId"] = focusId;
    map["deliveryPossible"] = deliveryPossible;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => this.id.hashCode;
}
