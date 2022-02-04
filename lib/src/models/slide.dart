import '../helpers/custom_trace.dart';

class Slide {
  String id;
  // ignore: non_constant_identifier_names
  String slider_text;
  // ignore: non_constant_identifier_names
  String redirect_type;
  // ignore: non_constant_identifier_names
  String para;
  String image;
  String 	superCategoryId;

  Slide();

  Slide.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      slider_text = jsonMap['slider_text'] != null ? jsonMap['slider_text'] : '';
      redirect_type = jsonMap['redirect_type'] != null ? jsonMap['redirect_type'] :  '';
      para = jsonMap['para'] != null ? jsonMap['para'] :  '';
      image = jsonMap['image'];
      superCategoryId = jsonMap['superCategoryId'] != null ? jsonMap['superCategoryId'] :  '';
    } catch (e) {
      id = '';
      slider_text = '';
      redirect_type = '';
      para = '';
      image = '';
      superCategoryId = '';

      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
