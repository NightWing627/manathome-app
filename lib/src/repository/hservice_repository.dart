import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:multisuperstore/src/models/bookingmodel.dart';
import 'package:multisuperstore/src/models/hsubcategory.dart';
import 'package:http/http.dart' as http;
import '../helpers/helper.dart';
import 'dart:convert';
import '../helpers/custom_trace.dart';
ValueNotifier<BookingModel> currentBookDetail = new ValueNotifier(BookingModel());
ValueNotifier<BookingModel> currentBookView = new ValueNotifier(BookingModel());
Future<Stream<HSubcategory>> getSubcategories(id) async {
  Uri uri = Helper.getUri('api/h_subcategories/$id');


  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => HSubcategory.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new HSubcategory.fromJSON({}));
  }
}

Future<Stream<HSubcategory>> getCategories() async {
  Uri uri = Helper.getUri('api/h_categories/');

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => HSubcategory.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new HSubcategory.fromJSON({}));
  }
}

Future<bool> bookOrderData(int i) async {

  print(currentBookDetail.value.toMap());

   final String url = '${GlobalConfiguration().getValue('base_url')}api/HBook/do_add';
   print(url);
  final client = new http.Client();
  final response = await client.put(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(currentBookDetail.value.toMap()),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw new Exception(response.body);
  }
}
