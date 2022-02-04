import 'package:global_configuration/global_configuration.dart';

import '../helpers/custom_trace.dart';


class HSubcategory {
  String id;
  String name;
  String image;

  HSubcategory();

  HSubcategory.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      name = jsonMap['name'];
      image =jsonMap['image'];
    } catch (e) {
      id = '';
      name = '';
      image = "${GlobalConfiguration().getValue('base_url')}images/image_default.png";
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
