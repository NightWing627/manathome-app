import '../helpers/custom_trace.dart';

class Registermodel {
  String name;
  // ignore: non_constant_identifier_names
  String email_id;
  String phone;
  String password;

  Registermodel();

  Registermodel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      name = jsonMap['name'];
      email_id = jsonMap['email_id'];
      phone = jsonMap['phone'];
      password = jsonMap['password'];
    } catch (e) {
      name = '';
      email_id = '';
      phone = '';
      password = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["email_id"] = email_id;
    map["phone"] = phone;
    map["password"] = password;
    return map;
  }
}
