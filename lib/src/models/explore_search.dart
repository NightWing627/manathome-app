import 'package:multisuperstore/src/models/shop_type.dart';

import '../helpers/custom_trace.dart';

class Explore {
  String id;
  String title;
  // ignore: non_constant_identifier_names
  // ignore: deprecated_member_use
  List<ShopType> focusType = List<ShopType>();

  Explore.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      title = jsonMap['title'];
      focusType = jsonMap['focusType']
          != null ? List.from(jsonMap['focusType']).map((element) => ShopType.fromJSON(element)).toList() : [];
    } catch (e) {
      id = '';
      title = '';
      focusType = [];
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
