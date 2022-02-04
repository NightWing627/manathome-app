import '../helpers/custom_trace.dart';

class DriverRatingModel {
  double rate;
  String message;
  String buyer;
  String driver;
  String orderId;

  DriverRatingModel();

  DriverRatingModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      rate = jsonMap['rate'];
      orderId = jsonMap['orderId'] !=null ?jsonMap['orderId']:false;
      message = jsonMap['message'] !=null ?jsonMap['message']:'';
      buyer = jsonMap['buyer'] !=null ?jsonMap['buyer']:'';
      driver = jsonMap['driver'] !=null ?jsonMap['driver']:'';
    } catch (e) {


      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["rate"] = rate;
    map["orderId"] = orderId;
    map["message"] = message;
    map["buyer"] = buyer;
    map["driver"] = driver;

    return map;
  }
}
