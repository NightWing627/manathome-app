
class HReview {
  String id;
  String review;
  String rate;
  String user;
  String date;

  HReview();

  HReview.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      review = jsonMap['review'];
      rate = jsonMap['rate'].toString() ?? '0';
      user = jsonMap['user'];
      date = jsonMap['date'];
    } catch (e) {
      id = '';
      review = '';
      rate = '0';
      user = '';
      date = '';
      print(e);
    }
  }
}
