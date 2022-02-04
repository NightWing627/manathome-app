import 'cart_responce.dart';
import 'delivery_status.dart';

class OrderList {
  String userid;
  // ignore: non_constant_identifier_names
  String sale_code;
  // ignore: non_constant_identifier_names
  List<CartResponce> product_details;
  //List<Address> address;
  String shipping;
  // ignore: non_constant_identifier_names
  String payment_type;
  // ignore: non_constant_identifier_names
  String payment_status;
  // ignore: non_constant_identifier_names
  String payment_timestamp;
  // ignore: non_constant_identifier_names
  String grand_total;
  // ignore: non_constant_identifier_names
  String sale_datetime;
  // ignore: non_constant_identifier_names
  String delivery_datetime;
  // ignore: non_constant_identifier_names
  List<DeliveryStatus> delivery_status;
  String orderType;
  String shopTypeId;

  OrderList();

  OrderList.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      userid = jsonMap['userid'].toString();
      sale_code = jsonMap['sale_code'] != null ? jsonMap['sale_code'] : null;
      product_details =
          jsonMap['product_details'] != null ? List.from(jsonMap['product_details']).map((element) => CartResponce.fromJSON(element)).toList() : [];
    //  address = jsonMap['address'] != null ? List.from(jsonMap['address']).map((element) => Address.fromJSON(element)).toList() : [];
      shipping = jsonMap['shipping'] != null ? jsonMap['shipping'] : null;
      payment_type = jsonMap['payment_type'] != null ? jsonMap['payment_type'] : null;
      payment_status = jsonMap['payment_status'] != null ? jsonMap['payment_status'] : null;
      payment_timestamp = jsonMap['payment_timestamp'] != null ? jsonMap['payment_timestamp'] : null;
      grand_total = jsonMap['grand_total'] != null ? jsonMap['grand_total'] : null;
      sale_datetime = jsonMap['sale_datetime'] != null ? jsonMap['sale_datetime'] : null;
      delivery_datetime = jsonMap['delivery_datetime'] != null ? jsonMap['delivery_datetime'] : null;
      orderType = jsonMap['orderType'] != null ? jsonMap['orderType'] : null;
      shopTypeId = jsonMap['shopTypeId'] != null ? jsonMap['shopTypeId'] : null;
      delivery_status =
          jsonMap['delivery_status'] != null ? List.from(jsonMap['delivery_status']).map((element) => DeliveryStatus.fromJSON(element)).toList() : [];
    } catch (e) {
      userid = '';
      sale_code = '';
      product_details = [];
      //address = [];
      shipping = '';
      payment_type = '';
      payment_status = '';
      payment_timestamp = '';
      grand_total = '';
      sale_datetime = '';
      delivery_datetime = '';
      delivery_status = [];

    }
  }
}
