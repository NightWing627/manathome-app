import '../helpers/custom_trace.dart';

class VendorSocialLinks {

  String faceBook;
  String whatsApp;
  String twitter;
  String instagram;

  VendorSocialLinks();

  VendorSocialLinks.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      faceBook=jsonMap['faceBook']!=null?jsonMap['faceBook']:'';
      whatsApp=jsonMap['whatsApp']!=null?jsonMap['whatsApp']:'';
      twitter=jsonMap['twitter']!=null?jsonMap['twitter']:'';
      instagram=jsonMap['instagram']!=null?jsonMap['instagram']:'';
    } catch (e) {

      print(e);
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map['faceBook']=faceBook;
    map['whatsApp']=whatsApp;
    map['twitter']=twitter;
    map['instagram']=instagram;
    return map;
  }
}
