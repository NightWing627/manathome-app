import 'dart:convert';
import 'dart:io';
import 'package:multisuperstore/src/models/cancelled.dart';
import 'package:multisuperstore/src/models/driver_rating.dart';
import 'package:multisuperstore/src/models/order_details.dart';
import 'package:multisuperstore/src/models/shop_rating.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';

import '../models/payment.dart';

import '../models/order_list.dart';
import '../models/order_track.dart';
import '../models/user.dart';
import '../models/review.dart';
import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/checkout.dart';
import '../models/coupons.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../repository/user_repository.dart' as userRepo;
import 'package:flutter/material.dart';

ValueNotifier<Checkout> currentCheckout = new ValueNotifier(new Checkout());



// ignore: missing_return
Future<Stream<Coupons>> getCoupon() async {
  Uri uri = Helper.getUri('api/coupons');

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => Coupons.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  }
}


// ignore: missing_return
Future<OrderDetailsModel> getInvoiceDetails(orderID) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}Api/Order/orderDetails/$orderID/null/${currentUser.value.id}?$_apiToken';
  print(url);
  OrderDetailsModel res;
  try {
    final client = new http.Client();
    final response = await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(''),
    );


     print(response.statusCode);
    if (response.statusCode == 200) {

      res = OrderDetailsModel.fromJSON(json.decode(response.body)['data']);
          
      // print(res.payment.toMap());
      return res;
    } else {
      throw new Exception(response.body);
    }
  } catch(e){
    print(e);
  }
}

Future<bool> addFavorite() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  final String _apiToken = 'api_token=${_user.apiToken}';

  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/favorite/do_add/${userRepo.currentUser.value.id}/?$_apiToken';
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

Future<String> bookOrderResp() async {
  Checkout _book = currentCheckout.value;
  User _user = userRepo.currentUser.value;

  final String _apiToken = 'api_token=${_user.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/order/test/${_user.id}?$_apiToken';

  final client = new http.Client();
  final response = await client.put(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(_book.toMap()),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body)['data'];
  } else {
    print('error');
    throw new Exception(response.body);
  }
}

Future<String> cancelledOrder(CancelledModel orderReason) async {
  User _user = userRepo.currentUser.value;

  final String _apiToken = 'api_token=${_user.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/cancelOrder/cancelled/${_user.id}?$_apiToken';

  final client = new http.Client();
  final response = await client.put(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(orderReason.toMap()),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body)['data'];
  } else {

    throw new Exception(response.body);
  }
}


Future<String> updateRating(ShopRatingModel data, orderId) async {
  User _user = userRepo.currentUser.value;

  final String _apiToken = 'api_token=${_user.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/rating/shoprating/${_user.id}/$orderId/?$_apiToken';

  final client = new http.Client();
  final response = await client.put(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(data.toMap()),
  );
  print(url);
  if (response.statusCode == 200) {
    return json.decode(response.body)['data'];
  } else {

    throw new Exception(response.body);
  }
}


Future<String> updateDriverRating(DriverRatingModel data) async {
  User _user = userRepo.currentUser.value;

  final String _apiToken = 'api_token=${_user.apiToken}';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/rating/driverrating/${_user.id}?$_apiToken';

  final client = new http.Client();
  final response = await client.put(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(data.toMap()),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body)['data'];
  } else {

    throw new Exception(response.body);
  }
}
Future<Stream<OrderList>> getOrders() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/order/list/${_user.id}?$_apiToken';
  print(url);
  print('geeting');
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return OrderList.fromJSON(data);
    });
  } catch (e) {
    print('error');
    print(e);
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new OrderList.fromJSON({}));
  }
}

Future<Stream<OrderTrack>> getOrdersTrack(String id) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(null);
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/order/ordertrack/$id?$_apiToken';
  print(url);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      print(data);
      return OrderTrack.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new OrderTrack.fromJSON({}));
  }
}

Future<bool> checkRating(id) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/review/check_rating/$id/${userRepo.currentUser.value.id}?$_apiToken';

  bool res;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );
  if (response.statusCode == 200) {
    if (json.decode(response.body)['data'] == 'already') {
      res = false;
    } else {
      res = true;
    }
  } else {
    throw new Exception(response.body);
  }
  return res;
}

Future<Review> addProductReview(Review review) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return Review.fromJSON({});
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/review/do_add?$_apiToken';
  final client = new http.Client();
  try {
    final response = await client.post(
        Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(review.toMap()),
    );
    if (response.statusCode == 200) {
      return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return Review.fromJSON({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return Review.fromJSON({});
  }
}

// ignore: non_constant_identifier_names
Future<Payment> PaymentDetails(id) async {
  // ignore: deprecated_member_use
  final String url = '${GlobalConfiguration().getString('api_base_url')}api/paymentDetails/list/$id';
   print(url);
  Payment paymentDetails;
  final client = new http.Client();
  final response = await client.post(
      Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(''),
  );
 print(json.decode(response.body)['data']);
  if (response.statusCode == 200) {

    paymentDetails = Payment.fromJSON(json.decode(response.body)['data']);

  } else {
    throw new Exception(response.body);
  }
  return paymentDetails;
}
