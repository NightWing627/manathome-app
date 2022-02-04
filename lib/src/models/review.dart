class Review {
  String id;
  String review;
  double rate = 0.0;
  // ignore: non_constant_identifier_names
  String user_id;
  // ignore: non_constant_identifier_names
  String product_id;

  Review();

  Review.init(this.rate);

  Review.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      review = jsonMap['review'];
      rate = jsonMap['rate'] ?? '0.0';
      user_id = jsonMap['user_id'];
      product_id = jsonMap['product_id'];
    } catch (e) {
      id = '';
      review = '';
      rate = 0.0;
      user_id = '';
      product_id = '';
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["review"] = review;
    map["rate"] = rate;
    map["user_id"] = user_id;
    map["product_id"] = product_id;
    return map;
  }
}
