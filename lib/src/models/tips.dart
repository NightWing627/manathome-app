import '../helpers/custom_trace.dart';

class Tips {
  int amount;
  bool selected = false;


  Tips();

  Tips.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      amount = jsonMap['amount'];
      selected = jsonMap['selected'];
    } catch (e) {
      amount = 0;
      selected = false;
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
