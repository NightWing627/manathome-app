import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:multisuperstore/src/models/product_details2.dart';
import 'package:multisuperstore/src/models/user.dart';
import 'package:multisuperstore/src/models/vendor_businesscard.dart';
import '../models/restaurant_product.dart';
import '../models/vendor.dart';
import 'user_repository.dart';
import '../helpers/helper.dart';
import 'dart:convert';
import '../helpers/custom_trace.dart';

ValueNotifier<Vendor> currentVendor = new ValueNotifier(Vendor());
ValueNotifier<Vendor> catchVendor = new ValueNotifier(Vendor());
Future<Stream<Vendor>> getVendorList(int shopType, int focusId) async {
  Uri uri = Helper.getUri('api/shoplist/$shopType/$focusId');
  Map<String, dynamic> _queryParams = {};


  _queryParams['myLat'] = currentUser.value.latitude.toString();
  _queryParams['myLon'] = currentUser.value.longitude.toString();
  uri = uri.replace(queryParameters: _queryParams);
 print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Vendor.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Vendor.fromJSON({}));
  }
}






Future<Stream<Vendor>> getVendorListOffer(shopType,  offer, offerType) async {
  Uri uri = Helper.getUri('api/shoplistOffer/$shopType/$offer/$offerType');
  Map<String, dynamic> _queryParams = {};


  _queryParams['myLat'] = currentUser.value.latitude.toString();
  _queryParams['myLon'] = currentUser.value.longitude.toString();
  uri = uri.replace(queryParameters: _queryParams);

  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Vendor.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Vendor.fromJSON({}));
  }
}

// ignore: non_constant_identifier_names
Future<Stream<RestaurantProduct>> get_restaurantProduct(id) async {
  Uri uri = Helper.getUri('api/category_wise_restaurantproduct/$id');
 print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => RestaurantProduct.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new RestaurantProduct.fromJSON({}));
  }
}

Future<VendorBusinessCard> vendorBusinessCard(id) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/bussinessCard/$id';
  print(url);
  VendorBusinessCard res;
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );



  if (response.statusCode == 200) {

        res = VendorBusinessCard.fromJSON(json.decode(response.body)['data']);


  } else {
    throw new Exception(response.body);
  }
  return res;
}

Future<bool> addFavoriteShop() async {
  User _user = currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  final String _apiToken = 'api_token=${_user.apiToken}';

  final String url = '${GlobalConfiguration().getValue('api_base_url')}api/favoriteShop/do_add/${currentUser.value.id}/?$_apiToken';
  print(url);
  try {
    final client = new http.Client();
    await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(_user.toMap()),
    );
    return true;
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return false;
  }
}

Future<Stream<Vendor>> getFavoritesShop() async {
  User _user = currentUser.value;
  if (_user.apiToken == null) {
    return Stream.value(null);
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url = '${GlobalConfiguration().getValue('api_base_url')}api/favoriteShop/list/${currentUser.value.id}?$_apiToken';
  print(url);
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
  try {
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Vendor.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new Vendor.fromJSON({}));
  }
}



Future<Stream<ProductDetails2>> getShopProductSlide(id) async {


  final String _apiToken = 'api_token=${currentUser.value.apiToken}&';
  final String url = '${GlobalConfiguration().getValue('api_base_url')}api/shopSetting/productList/$id/${currentUser.value.id}?$_apiToken';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
  try {
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => ProductDetails2.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new ProductDetails2.fromJSON({}));
  }
}