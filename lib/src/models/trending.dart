import '../helpers/custom_trace.dart';

class Trending {
  String id;
  String name;
  String image;

  Trending();

  Trending.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      image = jsonMap['image'];
    } catch (e) {
      id = '';
      name = '';
      image = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
