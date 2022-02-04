import '../helpers/custom_trace.dart';

class RecommendationModel {
  // ignore: non_constant_identifier_names
  String superId;
  // ignore: non_constant_identifier_names
  String shopTypeId;
  String shopFocusId;
  String name;
  String image;

  RecommendationModel();

  RecommendationModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      superId = jsonMap['superId'];
      shopTypeId = jsonMap['shopTypeId'];
      name = jsonMap['name'];
      shopFocusId = jsonMap['shopFocusId'];
      image = jsonMap['image'];

    } catch (e) {
      superId = '';
      shopTypeId = '';
      name = '';
      shopFocusId = '';
      image = '';

      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["superId"] = superId;
    map["shopTypeId"] = shopTypeId;
    map["name"] = name;
    map["shopFocusId"] = shopFocusId;
    map["image"] = image;
    return map;
  }

}
