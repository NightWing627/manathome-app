import 'variant.dart';
import 'addon.dart';

class ProductDetails3 {
  String id;
  // ignore: non_constant_identifier_names
  String product_name;
  int rating;
  String image;
  // ignore: non_constant_identifier_names
  int num_of_imgs;
  List<variantModel> variant;
  List<AddonModel> addon;
  ProductDetails3();

  ProductDetails3.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      product_name = jsonMap['product_name'];

      rating = jsonMap['rating'];
      image = jsonMap['image'];
      num_of_imgs = jsonMap['num_of_imgs'];
      variant =
      jsonMap['variant'] != null ? List.from(jsonMap['variant']).map((element) => variantModel.fromJSON(element)).toList() : [];
      addon =
      jsonMap['addon'] != null ? List.from(jsonMap['addon']).map((element) => AddonModel.fromJSON(element)).toList() : [];

    } catch (e) {
      id = '';
      product_name = '';

      rating = 0;
      image = '';
      num_of_imgs = 0;
      variant = [];
      addon = [];

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["product_name"] = product_name;
    map["rating"] = rating;
    map["image"] = image;
    map["num_of_imgs"] = num_of_imgs;
    return map;
  }
}
