import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/address.dart';
import 'package:multisuperstore/src/pages/otp_verification_email.dart';
import 'package:toast/toast.dart';

import '../models/registermodel.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';

class UserController extends ControllerMVC {
  User user = new User();
  bool hidePassword = true;
  Address addressData = Address();
  bool loading = false;
  String otpNumber;

  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<ScaffoldState> scaffoldKeyState;

  OverlayEntry loader;
  // ignore: non_constant_identifier_names
  Registermodel register_data = new Registermodel();

  UserController() {
    loader = Helper.overlayLoader(context);
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.scaffoldKeyState = new GlobalKey<ScaffoldState>();
    //_firebaseMessaging = FirebaseMessaging();

    //  listenForAddress();
  }

  void login({bool redirect = true}) async {
    try {
      FocusScope.of(context).unfocus();
      if (redirect) {
        if (loginFormKey.currentState.validate()) {
          loginFormKey.currentState.save();
        }
      }
      try {
        Overlay.of(context).insert(loader);
      } catch (e) {}
      repository.login(user).then((value) async {
        await Helper.hideLoader(loader);
        if (value != null && value.apiToken != null) {
          /**
            Fluttertoast.showToast(
            msg: "${S.of(context).login} ${S.of(context).successfully}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
          );
           **/
          gettoken();

          if (currentUser.value.latitude != 0.0 &&
              currentUser.value.longitude != 0.0) {
            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
          } else {
            Navigator.of(context).pushReplacementNamed('/location');
          }
        } else {
          // ignore: deprecated_member_use
          scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).wrong_email_or_password),
          ));
        }
      }).catchError((e) {
        Helper.hideLoader(loader);
        // ignore: deprecated_member_use
        scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_account_not_exist),
        ));
      });
    } catch (err) {
      Helper.hideLoader(loader);
      // ignore: deprecated_member_use
      scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
        content: Text(err.toString()),
      ));
    }
  }

  gettoken() {
    FirebaseMessaging.instance.getToken().then((deviceid) {
      print(deviceid);
      var table = 'user' + currentUser.value.id;
      FirebaseFirestore.instance.collection('devToken').doc(table).set({
        'devToken': deviceid,
        'userId': currentUser.value.id
      }).catchError((e) {
        print('firebase error');
        print(e);
      });
    });
  }

  void saveAddress() {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();

      setState(() => currentUser.value.address.add(addressData));
      setCurrentUserUpdate(currentUser.value);
      Navigator.pop(context);
    }
  }

  void register({bool redirect = true}) async {
    try {
      FocusScope.of(context).unfocus();
      if (redirect) {
        if (loginFormKey.currentState.validate()) {
          loginFormKey.currentState.save();
        }
      }

      try {
        Overlay.of(context).insert(loader);
      } catch (err) {}
      repository.register(register_data).then((value) {
        print(value);
        if (value == true) {
          showToast("${S.of(context).register} ${S.of(context).successfully}",
              gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
          if (redirect) {
            Helper.hideLoader(loader);
            Navigator.of(context).pushReplacementNamed('/Login');
          } else {
            user.email = register_data.email_id;
            user.password = register_data.password;
            login(redirect: false);
          }
        } else if (value == null) {
          user.email = register_data.email_id;
          user.password = register_data.password;
          login(redirect: false);
        } else {
          Helper.hideLoader(loader);
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).this_email_account_exists),
          ));
        }
      }).catchError((e) {
        Helper.hideLoader(loader);
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_email_account_exists),
        ));
      });
    } catch (err) {
      Helper.hideLoader(loader);
    }
  }

  void otpVerification(email) {
    var rng = new Random();
    String code = (rng.nextInt(9000) + 1000).toString();
    this.otpNumber = code;
    notifyListeners();
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();

      repository
          .resetPassword(register_data.email_id, code)
          .then((value) {})
          .whenComplete(() {
        Helper.hideLoader(loader);
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OtpVerificationEmail(
                email: email,
                otp: code,
              )));
    }
  }

  void resetPassword(email, otp) {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);

      repository.resetPassword(email, otp).then((value) {
        if (value != null && value == true) {
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content:
                Text(S.of(context).your_reset_link_has_been_sent_to_your_email),
            action: SnackBarAction(
              label: S.of(context).login,
              onPressed: () {},
            ),
            duration: Duration(seconds: 10),
          ));
        } else {
          loader.remove();
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).error_verify_email_settings),
          ));
        }
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }
}
