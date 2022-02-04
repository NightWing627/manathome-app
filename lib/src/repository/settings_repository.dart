import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multisuperstore/src/models/slide.dart';
import '../models/Dropdown.dart';
import '../helpers/helper.dart';
import '../models/logistics_pricing.dart';
import '../helpers/custom_trace.dart';
import '../models/setting.dart';
import '../models/tips.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:global_configuration/global_configuration.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
ValueNotifier<List<Tips>> currentTips = new ValueNotifier<List<Tips>>(<Tips>[]);
ValueNotifier<List<LogisticsPricing>> currentLogisticsPricing = new ValueNotifier<List<LogisticsPricing>>(<LogisticsPricing>[]);
final navigatorKey = GlobalKey<NavigatorState>();

Future<Setting> initSettings() async {
  Setting _setting;
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/setting';

  try {
    final response = await http.get(Uri.parse(url), headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (response.statusCode == 200 ) {
      if (json.decode(response.body)['data'] != null) {
        print(json.decode(response.body)['data']);
        _setting = Setting.fromJSON(json.decode(response.body)['data']);

        print(json.decode(response.body)['data']);
        // _setting.brightness.value = prefs.getBool('isDark') ?? false ? Brightness.dark : Brightness.light;
        setting.value = _setting;

        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        setting.notifyListeners();
      }
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return Setting.fromJSON({});
  }
  return setting.value;
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
}

Future<String> getDefaultLanguage(String defaultLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('language')) {
    defaultLanguage = prefs.get('language');
  }
  return defaultLanguage;
}

// ignore: missing_return
Future<Stream<Tips>> getTips() async {
  Uri uri = Helper.getUri('api/tips');
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Tips.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}

// ignore: missing_return
Future<Stream<DropDownModel>> getItems() async {
  Uri uri = Helper.getUri('api/logistics/items');

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => DropDownModel.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}

// ignore: missing_return
Future<Stream<LogisticsPricing>> getLogisticsPricing() async {
  Uri uri = Helper.getUri('api/logistics_pricing/get');
print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => LogisticsPricing.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }


}

Future<Stream<Slide>> getSlides(id) async {
  Uri uri = Helper.getUri('api/slider/$id');
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Slide.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Slide.fromJSON({}));
  }
}