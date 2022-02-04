import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/checkout.dart';
import '../models/product_details2.dart';
import '../models/search_catch.dart';
import '../models/timeslot.dart';
import '../models/category.dart';
import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/product.dart';
import '../models/cart_responce.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_repository.dart';

ValueNotifier<List<CartResponce>> currentCart =
    new ValueNotifier<List<CartResponce>>(<CartResponce>[]);
ValueNotifier<SearchCatch> currentSearch = new ValueNotifier(SearchCatch());
Future<Stream<Product>> getProductsByCategory(categoryId) async {
  Uri uri = Helper.getUri('api/category_wise_product/$categoryId');
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Product.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<ProductDetails2>> getProductlist(String type, searchTxt) async {
  Uri uri = Helper.getUri('api/productlist/$type');
  Map<String, dynamic> _queryParams = {};
  _queryParams['search'] = '$searchTxt';
  uri = uri.replace(queryParameters: _queryParams);
  log(uri.toString());
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => ProductDetails2.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ProductDetails2.fromJSON({}));
  }
}

void setCurrentCartItem() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('current_cart', json.encode(currentCart.value));
  print(currentCart.value.length);
}

void setCurrentCheckout(Checkout jsonString) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_checkout', json.encode(jsonString.toMap()));
  } catch (e) {
    print(e);
  }
}

Future<Checkout> getCurrentCheckout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    currentCheckout.value =
        Checkout.fromJSON(json.decode(prefs.get('current_checkout')));

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    currentCheckout.notifyListeners();
    currentCheckout.value.delivery_tips = 0;
  } catch (e) {}
  return currentCheckout.value;
}

Future<void> removeCheckout() async {
  currentCheckout.value = null;
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentCheckout.notifyListeners();
}

void clearCartItem() async {
  //currentCart.value = new CartResponce();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_cart');
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentCart.notifyListeners();
  print(currentCheckout.value.shopName);
}

Future<List<CartResponce>> getCurrentCartItem() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  currentCart.value = List.from(json.decode(prefs.get('current_cart')))
      .map((element) => CartResponce.fromJSON(element))
      .toList();
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentCart.notifyListeners();
  return currentCart.value;
}

Future<Stream<Category>> mostOfcategories() async {
  Uri uri = Helper.getUri('api/sub_categories');

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Category.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Category.fromJSON({}));
  }
}

// ignore: missing_return
Future<Stream<TimeSlot>> getTimeSlotData() async {
  Uri uri =
      Helper.getUri('api/deliverytimeslot/${currentCheckout.value.shopId}');
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => TimeSlot.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}
