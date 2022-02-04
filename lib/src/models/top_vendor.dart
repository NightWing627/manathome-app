


class TopVendorModel {
  String rating;
  String image;
  String type;
  String distance;
  String subtitle;
  String displayName;
  String id;
  String focusId;








  // used for indicate if client logged in or not
  bool auth;

//  String role;

  TopVendorModel();

  TopVendorModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      rating = jsonMap['rating'] != null ? jsonMap['rating'] : '';
      distance = jsonMap['distance'] != null ? jsonMap['distance'] : '';
      type = jsonMap['type'] != null ? jsonMap['type'] : 0;
      image = jsonMap['image'] != null ? jsonMap['image'] : '';
      subtitle = jsonMap['subtitle'] != null ? jsonMap['subtitle'] : '';
      displayName = jsonMap['displayName'] != null ? jsonMap['displayName'] : '';
      focusId = jsonMap['focusId'] != null ? jsonMap['focusId'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["rating"] = rating;
    map["distance"] = distance;
    map["image"] = image;
    map["type"] = type;
    map["displayName"] = displayName;
    map["subtitle"] = subtitle;
    map["id"] = id;




    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
