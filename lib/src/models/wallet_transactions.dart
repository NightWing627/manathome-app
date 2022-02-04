import '../helpers/custom_trace.dart';

class WalletTransactions {
  // ignore: non_constant_identifier_names
  String transactions_id;
  String type;
  String amount;
  String balance;
  String status;
  String date;
  // ignore: non_constant_identifier_names
  String 	access_vendor;
  // ignore: non_constant_identifier_names
  String product_id;


  WalletTransactions();

  WalletTransactions.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      transactions_id = jsonMap['transactions_id'] ?? null;
      type = jsonMap['type'] ?? null;
      amount = jsonMap['amount'] ?? 0.0;
      balance = jsonMap['balance']?? 0.0;
      status = jsonMap['status'] ?? null;
      date = jsonMap['date'] ?? null;
      access_vendor = jsonMap['access_vendor'] ?? null;
      product_id = jsonMap['product_id'] ?? null;

    } catch (e) {

      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
