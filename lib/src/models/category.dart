import '../helpers/custom_trace.dart';

class Category {
  String id;
  String name;
  String image;
  bool select;

  Category();

  Category.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      image = jsonMap['image'];
      select = jsonMap['select'];
    } catch (e) {
      id = '';
      name = '';
      image = '';

      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
