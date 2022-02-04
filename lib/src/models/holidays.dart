import '../helpers/custom_trace.dart';

class HolidaysModel {
  bool monVal = false;
  bool tueVal = false;
  bool wedVal = false;
  bool thurVal = false;
  bool friVal = false;
  bool satVal = false;
  bool sunVal = false;

  HolidaysModel();

  HolidaysModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      monVal = jsonMap['monVal'] != null ?jsonMap['monVal'] : false;
      tueVal = jsonMap['tueVal'] != null ?jsonMap['tueVal'] : false;
      wedVal = jsonMap['wedVal'] != null ?jsonMap['wedVal'] : false;
      thurVal = jsonMap['thurVal'] != null ?jsonMap['thurVal'] : false;
      friVal = jsonMap['friVal'] != null ?jsonMap['friVal'] : false;
      satVal = jsonMap['satVal'] != null ?jsonMap['satVal'] : false;
      sunVal = jsonMap['sunVal'] != null ?jsonMap['sunVal'] : false;

    } catch (e) {

      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["monVal"] = monVal;
    map["tueVal"] = tueVal;
    map["wedVal"] = wedVal;
    map["thurVal"] = thurVal;
    map["friVal"] = friVal ;
    map["satVal"] = satVal;
    map["sunVal"] = sunVal;

    return map;
  }


}
