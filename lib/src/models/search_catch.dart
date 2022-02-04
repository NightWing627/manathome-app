import '../helpers/custom_trace.dart';

class SearchCatch {
  String shopId;
  String shopName;
  String subtitle;
  String km;
  int shopTypeID;
  String latitude;
  String longitude;

  SearchCatch();

  SearchCatch.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      shopId = jsonMap['shopId'];
      shopName = jsonMap['shopName'];
      subtitle = jsonMap['subtitle'];
      km = jsonMap['km'];
      shopTypeID = jsonMap['shopTypeID'];
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longitude'];
    } catch (e) {
      shopId = '';
      shopName = '';
      subtitle = '';
      km = '';
      shopTypeID = 0;
      latitude = '';
      longitude = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
