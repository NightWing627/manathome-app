import '../helpers/custom_trace.dart';

class Wallet {
  // ignore: non_constant_identifier_names
  String wallet_id;
  // ignore: non_constant_identifier_names
  String user_id;
  String balance;

  Wallet();

  Wallet.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      wallet_id = jsonMap['wallet_id'];
      user_id = jsonMap['user_id'];
      balance = jsonMap['balance'];
    } catch (e) {
      wallet_id = '';
      user_id = '';
      balance = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
