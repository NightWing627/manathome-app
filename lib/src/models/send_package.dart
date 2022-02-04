import 'address.dart';
import 'payment.dart';
import '../helpers/custom_trace.dart';


class SendPackage {
  String id;
  Address pickupAddress = new Address();
  Address deliveryAddress = new Address();
  Payment payment = new Payment();
  String message;
  String itemId;
  String itemName;
  // ignore: non_constant_identifier_names
  double grand_total = 0.0;
  double discount = 0.0;
  // ignore: non_constant_identifier_names
  double sub_total = 0.0;
  String userId;
  String saleCode;
  int shopTypeID = 0;
  double km = 0.0;
  // ignore: non_constant_identifier_names
  int delivery_fees = 0;
  // ignore: non_constant_identifier_names
  int delivery_tips =0;




  SendPackage();

  SendPackage.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();

      pickupAddress = jsonMap['pickupAddress'] != null ? Address.fromJSON(jsonMap['pickupAddress']) : Address.fromJSON({});
      deliveryAddress = jsonMap['deliveryAddress'] != null ? Address.fromJSON(jsonMap['deliveryAddress']) : Address.fromJSON({});
      payment = jsonMap['payment'] != null ? Payment.fromJSON(jsonMap['payment']) : Payment.fromJSON({});
      grand_total = jsonMap['grand_total'] != null ? jsonMap['grand_total'].toDouble() : 0;
      discount = jsonMap['discount']!= null ? jsonMap['discount'] : '';
      sub_total = jsonMap['sub_total']!= null ? jsonMap['sub_total'] : '';
      userId = jsonMap['userID']!= null ? jsonMap['userID'] : '';
      saleCode = jsonMap['saleCode']!= null ? jsonMap['saleCode'] : '';
      shopTypeID = jsonMap['shopTypeID'];
      km = jsonMap['km'];
      itemId = jsonMap['itemId'];
      itemName = jsonMap['itemName'];
      message = jsonMap['message'];
      delivery_fees = jsonMap['delivery_fees'];
      delivery_tips = jsonMap['delivery_tips'];

    } catch (e) {
      id = '';
      grand_total = 0;
      pickupAddress = Address.fromJSON({});
      deliveryAddress = Address.fromJSON({});
      payment = Payment.fromJSON({});
      userId = '';
      saleCode = '';
      km =0.0;
      delivery_fees = 0;
      delivery_tips = 0;
      message = '';
      itemId = '';
      itemName = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "pickupAddress": pickupAddress.toMap(),
    "deliveryAddress": deliveryAddress.toMap(),
    "payment": payment.toMap(),
    "grand_total": grand_total,
    "sub_total": sub_total,
    "discount": discount,
    "userId": userId,
    "saleCode": saleCode,
    "km": km,
    "delivery_fees": delivery_fees,
    "delivery_tips": delivery_tips,
    "itemId": itemId,
    "itemName": itemName,
    "message": message
  };


  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["pickupAddress"] = pickupAddress.toMap();
    map["deliveryAddress"] = deliveryAddress.toMap();
    map["payment"] = payment.toMap();
    map["grand_total"] = grand_total;
    map["sub_total"] = sub_total;
    map["discount"] = discount;
    map["userId"] = userId;
    map["saleCode"] = saleCode;
    map["shopTypeID"] = shopTypeID;
    map["km"] = km;
    map["delivery_fees"] = delivery_fees;
    map["delivery_tips"] = delivery_tips;
    map["itemId"] = itemId;
    map["itemName"] = itemName;
    map["message"] = message;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => this.id.hashCode;
}
