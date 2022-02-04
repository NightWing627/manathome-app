import '../helpers/custom_trace.dart';

class StatusManager {
  String type;
  bool placedstatus;
  int placedtime;
  bool acceptstatus;
  int accepttime;
  bool packedstatus;
  int packedtime;
  bool shippedstatus;
  int shippedtime;
  bool deliverstatus;
  int delivered;

  StatusManager();

  StatusManager.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      placedstatus = jsonMap['placedstatus'];
      placedtime = jsonMap['placedtime'];
      acceptstatus = jsonMap['acceptstatus'];
      accepttime = jsonMap['accepttime'];
      packedstatus = jsonMap['packedstatus'];
      packedtime = jsonMap['packedtime'];
      shippedstatus = jsonMap['shippedstatus'];
      shippedtime = jsonMap['shippedtime'];
      deliverstatus = jsonMap['deliverstatus'];
      delivered = jsonMap['delivered'];
    } catch (e) {
      placedstatus = false;
      placedtime = 0;
      acceptstatus = false;
      accepttime = 0;
      packedstatus = false;
      packedtime = 0;
      shippedstatus = false;
      shippedtime = 0;
      deliverstatus = false;
      delivered = 0;
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["placedstatus"] = placedstatus;
    map["placedtime"] = placedtime;
    map["acceptstatus"] = acceptstatus;
    map["accepttime"] = accepttime;
    map["packedstatus"] = packedstatus;
    map["packedtime"] = packedtime;
    map["shippedstatus"] = shippedstatus;
    map["shippedtime"] = shippedtime;
    map["deliverstatus"] = deliverstatus;
    map['delivered'] = delivered;
    return map;
  }
}
