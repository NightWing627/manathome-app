import 'product_details2.dart';
import '../helpers/custom_trace.dart';

class Product {
  String id;
  String image;
  // ignore: non_constant_identifier_names
  String subcategory_name;
  // ignore: non_constant_identifier_names
  List<ProductDetails2> productdetails;

  Product();

  Product.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      image = jsonMap['image'];
      productdetails =
          jsonMap['productdetails'] != null ? List.from(jsonMap['productdetails']).map((element) => ProductDetails2.fromJSON(element)).toList() : [];
      subcategory_name = jsonMap['subcategory_name'];
    } catch (e) {
      id = '';
      image = '';
      subcategory_name = '';
      productdetails = [];

      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
