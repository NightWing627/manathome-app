import '../helpers/custom_trace.dart';

class Coupons {
  String title;
  String valid;
  String code;
  // ignore: non_constant_identifier_names
  String discount_type;
  // ignore: non_constant_identifier_names
  String discount_value;
  // ignore: non_constant_identifier_names
  String minimum_buy;
  Coupons();

  Coupons.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      title = jsonMap['title'];
      valid = jsonMap['valid'];
      code = jsonMap['code'];
      discount_type = jsonMap['discount_type'];
      discount_value = jsonMap['discount_value'];
      minimum_buy = jsonMap['minimum_buy'];
    } catch (e) {
      title = '';
      valid = '';
      code = '';
      discount_type = '';
      discount_value = '';
      minimum_buy = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
