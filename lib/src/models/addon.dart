import 'dart:developer';

import '../helpers/custom_trace.dart';

class AddonModel {
  // ignore: non_constant_identifier_names
  String addon_id;
  // ignore: non_constant_identifier_names
  String product_id;
  String name;
  String price;
  String type;
  bool selected;
  String foodType;
  String category;
  AddonModel();

  AddonModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      addon_id = jsonMap['addon_id'];
      product_id = jsonMap['product_id'];
      name = jsonMap['name'];
      price = jsonMap['price'];
      type = jsonMap['type'];
      selected = jsonMap['selected'];
      foodType = jsonMap['foodType'];
      category = jsonMap['category'];
      log(category);
    } catch (e) {
      addon_id = '';
      product_id = '';
      name = '';
      price = '';
      type = '';
      selected = false;
      foodType = '';
      category = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["addon_id"] = addon_id;
    map["product_id"] = product_id;
    map["name"] = name;
    map["price"] = price;
    map["type"] = type;
    map["selected"] = selected;
    map["foodType"] = foodType;
    return map;
  }

}
