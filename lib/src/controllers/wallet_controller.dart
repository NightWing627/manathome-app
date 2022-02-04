import 'package:flutter/material.dart';
import 'package:multisuperstore/src/pages/payment_wallet.dart';
import 'package:toast/toast.dart';
import '../helpers/helper.dart';
import '../models/recharge.dart';
import '../models/wallet_transactions.dart';
import '../models/wallet.dart';
import '../repository/wallet_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class WalletController extends ControllerMVC {
  List<Wallet> walletList = <Wallet>[];
  List<WalletTransactions> walletTransactionList = <WalletTransactions>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  Recharge rechargeData = new Recharge();
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> RechargeFormKey;
  OverlayEntry loader;
  WalletController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    RechargeFormKey = new GlobalKey<FormState>();
    listenForWallet();
    loader = Helper.overlayLoader(context);
  }


  Future<void> listenForWallet() async {
    final Stream<Wallet> stream = await getWallet();
    stream.listen((Wallet _walletAmount) {
      setState(() => walletList.add(_walletAmount));
      walletList.forEach((element) {
         print(element.balance);
      });

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForWalletTransaction() async {
    final Stream<WalletTransactions> stream = await getTransaction('recent');
    stream.listen((WalletTransactions _walletAmount) {
      setState(() => walletTransactionList.add(_walletAmount));
      walletTransactionList.forEach((element) {
        print(element.balance);
      });

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  recharge(amount){

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentWalletPage(amount: amount,)));
   /** if (amount!='') {
      
      rechargeData.user_id = currentUser.value.id;
      rechargeData.type = 'credit';
      rechargeData.amount = amount;
      Overlay.of(context).insert(loader);
      SendRecharge(rechargeData).then((value) {

        if (value == true) {
          Navigator.of(context).pushReplacementNamed('/WThankyou');
        } else {
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text('Error'),
          ));
        }
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('Enter your amount'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    } */
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }



}
