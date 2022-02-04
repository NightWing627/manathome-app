import 'dart:developer';

import 'addon.dart';
import 'variant.dart';

class ProductDetails2 {
  String id;
  // ignore: non_constant_identifier_names
  String product_name;
  int rating;
  String image;
  // ignore: non_constant_identifier_names
  int num_of_imgs;
  List<variantModel> variant;
  List<AddonModel> addon;
  String productType;
  List<String> categoryAddons;
  ProductDetails2();

  ProductDetails2.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      product_name = jsonMap['product_name'];

      rating = jsonMap['rating'];
      image = jsonMap['image'];
      num_of_imgs = jsonMap['num_of_imgs'];
      variant = jsonMap['variant'] != null
          ? List.from(jsonMap['variant'])
              .map((element) => variantModel.fromJSON(element))
              .toList()
          : [];
      productType = jsonMap['productType'];
      categoryAddons = List<String>.from(jsonMap['categoryAddon']);
      addon = jsonMap['addon'] != null
          ? 
              List.from(jsonMap['addon'])
                  .map((element) => AddonModel.fromJSON(element))
                  .toList()
          : [];
      log(categoryAddons.length.toString());
    } catch (e) {
      id = '';
      product_name = '';

      rating = 0;
      image = '';
      num_of_imgs = 0;
      variant = [];
      productType = '';
      addon = [];
      categoryAddons = [];
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
    map["productType"] = num_of_imgs;
    map["categoryAddon"] = categoryAddons;
    return map;
  }

  List<AddonModel> reorderAddonsByCategories(
      List<String> categories, List<AddonModel> addons) {
    List<String> checked = [];
    List<AddonModel> reorderedList = [];
    for (String cat in categories) {
      for (AddonModel addonModel in addons) {
        if (addonModel.category == cat && checked.contains(addonModel.name+addonModel.category)) {
          reorderedList.add(addonModel);
          checked.add(addonModel.name+addonModel.category);
        }
      }
    }
    log(checked.toString());
    return reorderedList;
  }
}
