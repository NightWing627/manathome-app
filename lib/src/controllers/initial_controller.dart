import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/settings_repository.dart';
import '../models/tips.dart';
import '../models/logistics_pricing.dart';

class InitialController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Tips> tipsList = <Tips>[];
  List<LogisticsPricing> logisticsPriceList = <LogisticsPricing>[];
  InitialController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {


    // settingRepo.initSettings();

    super.initState();
  }

  listenForTips() async {
    currentTips.value.clear();
    final Stream<Tips> stream = await getTips();
    stream.listen((Tips _tips) {
      setState(() => tipsList.add(_tips));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      currentTips.value.addAll(tipsList);
    });
  }

  listenForLogisticsPricing() async {
    final Stream<LogisticsPricing> stream = await getLogisticsPricing();
    stream.listen((LogisticsPricing _list) {
      setState(() => logisticsPriceList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {

      currentLogisticsPricing.value.addAll(logisticsPriceList);
      print('len${currentLogisticsPricing.value.length}');
    });
  }
}
