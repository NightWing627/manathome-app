import '../helpers/custom_trace.dart';


class SendOTP {
  String name;
  String phone;
  // ignore: non_constant_identifier_names
  String OTP;

  SendOTP();

  SendOTP.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      name = jsonMap['name'];
      phone = jsonMap['phone'];
      OTP = jsonMap['OTP'];
    } catch (e) {
      name = '';
      phone = '';
      OTP = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }


  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["phone"] = phone;
    map["OTP"] = OTP;

    return map;
  }
}
