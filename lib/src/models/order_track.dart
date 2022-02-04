import 'address.dart';
import 'status_manager.dart';
import '../helpers/custom_trace.dart';

class OrderTrack {
  String id;
  String status;
  Address address;
  String dateTime;
  String otp;
  StatusManager statusManager;

  OrderTrack();

  OrderTrack.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      status = jsonMap['status'];
      address = jsonMap['address'] != null && (jsonMap['address'] as List).length > 0 ? Address.fromJSON(jsonMap['address'][0]) : new Address();
      statusManager = jsonMap['statusManager'] != null && (jsonMap['statusManager'] as List).length > 0
          ? StatusManager.fromJSON(jsonMap['statusManager'][0])
          : new StatusManager();
      dateTime = jsonMap['dateTime'];
      otp = jsonMap['otp'];
    } catch (e) {
      id = '';
      status = '';
      otp = '';
      address = Address.fromJSON({});
      statusManager = StatusManager.fromJSON({});
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["status"] = status;
    map["otp"] = otp;
    map["address"] = address?.toMap();
    map["statusManager"] = statusManager?.toMap();
    map["dateTime"] = dateTime;
    return map;
  }
}
