import '../helpers/custom_trace.dart';

class ReviewList {
  // ignore: non_constant_identifier_names
  String comments_id;
  // ignore: non_constant_identifier_names
  String user_id;
  String name;
  String rating;
  String comments;
  int date;
  String image;

  ReviewList();

  ReviewList.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      comments_id = jsonMap['comments_id'].toString();
      user_id = jsonMap['user_id'];
      name = jsonMap['name'];
      rating = jsonMap['rating'];
      comments = jsonMap['comments'];
      date = jsonMap['date'];
      image = jsonMap['image'];
    } catch (e) {
      comments_id = '';
      user_id = '';
      name = '';
      rating = '';
      comments = '';
      date = 0;
      image = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
