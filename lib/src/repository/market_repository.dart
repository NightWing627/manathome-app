import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multisuperstore/src/models/providerlist.dart';
import 'package:multisuperstore/src/models/shop_type.dart';
import 'package:multisuperstore/src/models/vendor.dart';
import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../repository/user_repository.dart';
import 'hservice_repository.dart';

Future<Stream<Vendor>> getNearMarkets(Address myLocation, Address areaLocation, id) async {
  Uri uri = Helper.getUri('api/home_settings/topvendor/$id');
  Map<String, dynamic> _queryParams = {};

  _queryParams['myLon'] = currentUser.value.longitude.toString();
  _queryParams['myLat'] =  currentUser.value.latitude.toString();


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

    print(e);
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Vendor.fromJSON({}));
  }
}



Future<Stream<ProviderList>> getNearProvider(Address myLocation, Address areaLocation) async {
  Uri uri = Helper.getUri('api/listProvider/${currentBookDetail.value.categoryId}/${currentBookDetail.value.subcategoryId}');
  Map<String, dynamic> _queryParams = {};

  _queryParams['myLon'] = currentBookDetail.value.longitude.toString();
  _queryParams['myLat'] = currentBookDetail.value.latitude.toString();


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
        .map((data) {
      return ProviderList.fromJSON(data);
    });
  } catch (e) {
    print('error $e');
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ProviderList.fromJSON({}));
  }
}


Future<Stream<ShopType>> getShopType() async {

  Uri uri = Helper.getUri('api/home_settings/shoptype');


    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return ShopType.fromJSON(data);
    });

}


