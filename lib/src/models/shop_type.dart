import '../helpers/custom_trace.dart';

class ShopType {
  String title;
  String previewImage;
  String coverImage;
  String shopType;
  String homeShopType;
  String id;

  ShopType();

  ShopType.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id']!= null ? jsonMap['id'] : 0.0;
      title = jsonMap['title']!= null ? jsonMap['title'] : 0.0;
      previewImage = jsonMap['previewImage']!= null ? jsonMap['previewImage'] : 0.0;
      coverImage = jsonMap['coverImage']!= null ? jsonMap['coverImage'] : 0.0;
      shopType = jsonMap['shopType']!= null ? jsonMap['shopType'] : '';
      homeShopType =  jsonMap['homeShopType']!= null ? jsonMap['homeShopType'] :'';
    } catch (e) {
      id ='';
      previewImage = '';
      coverImage = '';
      title = '';
      shopType = '';
      print(e);
      print(CustomTrace(StackTrace.current, message: e));

    }
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "previewImage": previewImage,
    "coverImage": coverImage,
    "shopType": shopType,
    "homeShopType": homeShopType,
  };
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["title"] = title;
    map["previewImage"] = previewImage;
    map["coverImage"] = coverImage;
    map["shopType"] = shopType;
    map["homeShopType"] = homeShopType;
    return map;
  }
}
