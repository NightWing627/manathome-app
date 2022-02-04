import 'address.dart';
import '../helpers/custom_trace.dart';
import 'cart_responce.dart';

class SubscriptionCheckout {
  String id;
  List<CartResponce> cart = <CartResponce>[];
  Address address = new Address();
  // ignore: non_constant_identifier_names
  String grand_total;
  int discount;
  // ignore: non_constant_identifier_names
  int sub_total;
  String userId;
  String saleCode;
  String couponCode;
  bool couponStatus = false;
  String deliveryTimeSlot;
  String deliveryTime;
  String subscriptionStartFrom;
  String variant;
  String frequency;
  String status;
  // ignore: non_constant_identifier_names
  String product_id;

  SubscriptionCheckout();

  SubscriptionCheckout.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      cart = jsonMap['cart'] != null ? List.from(jsonMap['cart']).map((element) => CartResponce.fromJSON(element)).toList() : [];

      address = jsonMap['address'];
      variant = jsonMap['variant'];
      grand_total = jsonMap['grand_total'];
      discount = jsonMap['discount'];
      sub_total = jsonMap['sub_total'];
      userId = jsonMap['userID'];
      saleCode = jsonMap['saleCode'];
      couponCode = jsonMap['couponCode'];
      couponStatus = jsonMap['couponStatus'];
      deliveryTimeSlot = jsonMap['deliveryTimeSlot'];
      deliveryTime = jsonMap['deliveryTime'];
      frequency = jsonMap['frequency'];
      subscriptionStartFrom = jsonMap['subscriptionStartFrom'];
      status = jsonMap['status'];
      product_id = jsonMap['product_id'];
    } catch (e) {
      id = '';
      grand_total = '';
      cart = [];
      address = Address.fromJSON({});
      variant = '';
      userId = '';
      saleCode = '';
      couponCode = '';

      couponStatus = false;
      deliveryTimeSlot = '';
      deliveryTime = '';
      subscriptionStartFrom ='';
      frequency = '';
      status = '';
      product_id = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["cart"] = cart?.map((element) => element.toMap())?.toList();
    map["address"] = address.toMap();
    map["grand_total"] = grand_total;
    map["variant"] = variant;
    map["sub_total"] = sub_total;
    map["discount"] = discount;
    map["userId"] = userId;
    map["saleCode"] = saleCode;
    map["couponCode"] = couponCode;
    map["couponStatus"] = couponStatus;
    map["deliveryTimeSlot"] = deliveryTimeSlot;
    map["deliveryTime"] = deliveryTime;
    map['subscriptionStartFrom']= subscriptionStartFrom;
    map["frequency"] = frequency;
    map["product_id"] = product_id;
    map["status"] = status;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => this.id.hashCode;
}
