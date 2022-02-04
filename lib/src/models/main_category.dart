

import '../helpers/custom_trace.dart';

class MainCategoryModel {
  String id;
  String name;
  bool selected;


  MainCategoryModel();

  MainCategoryModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      name = jsonMap['name'];
      selected = jsonMap['selected'];

    } catch (e) {
      id = '';
      name = '';
      selected = false;
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
