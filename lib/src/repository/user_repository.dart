import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../models/registermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());

Future<int> updatePassword(String email, String password) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}Api/updatePassword';
  log(Uri.parse(url).toString());
  final client = new http.Client();
  final response = await client.put(Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode({'email':  email, 'password': password}));
  print(response.statusCode);
  return response.statusCode;
}

Future<User> login(User user) async {
  // ignore: deprecated_member_use
  print('login login login login login');
  print(user.email);
  print(user.password);
  print('login login login login login end end');
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}api/login';
  print(url);
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );

  //print(json.decode(response.body)['data']);
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);

    print(currentUser.value.toMap());
  } else {
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<bool> resetPassword(email, otp) async {
  Uri uri = Uri.parse(
      "${GlobalConfiguration().getValue('base_url')}Email/resetPassword/");
  // ignore: deprecated_member_use

  try {
    var request = http.MultipartRequest('POST', uri);

    request.fields['email'] = email;
    request.fields['otp'] = otp;
    request.fields['type'] = 'user';

    var response = await request.send();

    if (response.statusCode == 200) {
      response.stream.bytesToString().asStream().listen((event) {
        print(response.statusCode);
        //It's done...
      });
    } else {}
  } catch (e) {}
}

Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

Future<bool> register(Registermodel user) async {
  // ignore: deprecated_member_use
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}api/register';

  bool res;
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  print('register start ****');
  print(response.body);
  print('*** register end ***');

  if (response.statusCode == 200) {
    // setCurrentUser(response.body);
    // currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    if (json.decode(response.body)['data'] == 'success') {
      res = true;
    } else if (json.decode(response.body)['data'] == 'Already Registered') {
      res = null;
    } else {
      res = false;
    }
  } else {
    throw new Exception(response.body);
  }
  return res;
}

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['data'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'current_user', json.encode(json.decode(jsonString)['data']));
  }
}

void setCurrentUserUpdate(User jsonString) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(jsonString.toMap()));
    update(jsonString);
  } catch (e) {
    print('store error $e');
  }
}

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value = User.fromJSON(json.decode(prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<User> update(User user) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url =
      '${GlobalConfiguration().getString('base_url')}api/profileupdate/${currentUser.value.id}?$_apiToken';
  print(url);
  final client = new http.Client();
  await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  //setCurrentUser(response.body);
  //currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  return currentUser.value;
}
