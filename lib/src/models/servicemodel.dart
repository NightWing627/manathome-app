
class Servicemodel{
  // ignore: non_constant_identifier_names
  String services_name;
  String amount;
  // ignore: non_constant_identifier_names
  String servicesid;

  Servicemodel();

  Servicemodel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      services_name = jsonMap['services_name'];
      amount = jsonMap['amount'];
      servicesid = jsonMap['servicesid'];
    } catch (e) {
      services_name = '';
      amount = '';
      servicesid = '';
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["services_name"] = services_name;
    map["amount"] = amount;
    map["servicesid"] = servicesid;
    return map;
  }
}