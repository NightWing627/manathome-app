import '../helpers/custom_trace.dart';


class StatusManager {
  bool serviceBooked = false;
  int serviceBookedTime;
  bool serviceAccepted= false;
  int serviceAcceptedTime;
  bool startedCustomerPlaced= false;
  int startedCustomerPlacedTime;
  bool providerArrived= false;
  int providerArrivedTime;
  bool jobStarted = false;
  int jobStartedTime;
  bool jobCompleted = false;
  int jobCompletedTime;
  bool rejected = false;
  int rejectedTime;
  String bookId;
  StatusManager();

  StatusManager.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      serviceBooked = jsonMap['serviceBooked'];
      serviceBookedTime = jsonMap['serviceBookedTime'];
      serviceAccepted = jsonMap['serviceAccepted'];
      serviceAcceptedTime = jsonMap['serviceAcceptedTime'];
      startedCustomerPlaced = jsonMap['startedCustomerPlaced'];
      startedCustomerPlacedTime = jsonMap['startedCustomerPlacedTime'];
      providerArrived = jsonMap['providerArrived'];
      providerArrivedTime = jsonMap['providerArrivedTime'];
      jobStarted = jsonMap['jobStarted'];
      jobStartedTime = jsonMap['jobStartedTime'];
      jobCompleted = jsonMap['jobCompleted'];
      jobCompletedTime = jsonMap['jobCompletedTime'];
      rejected = jsonMap['rejected'];
      rejectedTime = jsonMap['rejectedTime'];
      bookId = jsonMap['bookId'];
    } catch (e) {
      serviceBooked = false;
      serviceBookedTime = 0;
      serviceAccepted = false;
      serviceAcceptedTime = 0;
      startedCustomerPlaced = false;
      startedCustomerPlacedTime = 0;
      providerArrived = false;
      providerArrivedTime = 0;
      jobStarted = false;
      jobStartedTime = 0;
      jobCompleted = false;
      jobCompletedTime = 0;
      rejected = false;
      rejectedTime = 0;
      bookId  ='';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["serviceBooked"] = serviceBooked;
    map["serviceBookedTime"] = serviceBookedTime;
    map["serviceAccepted"] = serviceAccepted;
    map["serviceAcceptedTime"] = serviceAcceptedTime;
    map["startedCustomerPlaced"] = startedCustomerPlaced;
    map["startedCustomerPlacedTime"] = startedCustomerPlacedTime;
    map["providerArrived"] = providerArrived;
    map["providerArrivedTime"] = providerArrivedTime;
    map["jobStarted"] = jobStarted;
    map["jobStartedTime"] = jobStartedTime;
    map["jobCompleted"] = jobCompleted;
    map["jobCompletedTime"] = jobCompletedTime;
    map["rejected"] = rejected;
    map["rejectedTime"] = rejectedTime;
    map["bookId"] = bookId;
    return map;
  }

}
