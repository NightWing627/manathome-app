import '../helpers/custom_trace.dart';
import 'servicemodel.dart';

class ProviderList {
  // ignore: non_constant_identifier_names
  String vendor_id;
  String name;
  String subtitle;
  String rating;
  String outof;
  String latitude;
  String longitude;
  String mobile;
  String address;
  String image;
  double distance;
  String chargephrs;
  bool closed;
  List<Servicemodel> service;

  ProviderList();

  ProviderList.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      vendor_id = jsonMap['vendor_id'];
      name = jsonMap['name'];
      subtitle = jsonMap['subtitle'];
      rating = jsonMap['rating'];
      outof = jsonMap['outof'];
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longitude'];
      mobile = jsonMap['mobile'];
      image = jsonMap['image'];
      distance = jsonMap['distance'] != null ? double.parse(jsonMap['distance'].toString()) : 0.0;
      chargephrs = jsonMap['chargephrs'];
      closed = jsonMap['closed'] ?? false;
      service = jsonMap['service'] != null ? List.from(jsonMap['service']).map((element) => Servicemodel.fromJSON(element)).toList() : [];
    } catch (e) {
      vendor_id = '';
      name = '';
      subtitle = '';
      rating = '';
      outof = '';
      latitude = '';
      longitude = '';
      mobile = '';
      image = '';
      distance = 0.0;
      chargephrs = '';
      closed = false;
      service = [];
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': vendor_id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'chargephrs': chargephrs,
      'distance': distance,
    };
  }
}
