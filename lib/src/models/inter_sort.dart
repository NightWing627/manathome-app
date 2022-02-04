import '../helpers/custom_trace.dart';

class InterSortView {
  String title;
  String sort;
  String image;

  InterSortView();

  InterSortView.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      title = jsonMap['title'];
      sort = jsonMap['sort'];
      image = jsonMap['image'];
    } catch (e) {
      title = '';
      sort = '';
      image = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
