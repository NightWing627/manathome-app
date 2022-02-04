import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/settings_repository.dart' as settingRepo;


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
class SplashScreenController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;

  //final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // Should define these variables before the app loaded
    progress.value = {"Setting": 0, "User": 0};
  }

  @override
  void initState() {
    super.initState();


    settingRepo.setting.addListener(() {
      progress.value["Setting"] = 41;
      progress.value["User"] = 59;
      print('success');
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      progress?.notifyListeners();
    });


    Timer(Duration(seconds: 20), () {
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Verify your internet'),
      ));
    });
  }
}