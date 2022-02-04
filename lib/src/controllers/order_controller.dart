import 'package:flutter/material.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/cancelled.dart';
import 'package:multisuperstore/src/models/order_details.dart';
import 'package:multisuperstore/src/models/shop_rating.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:toast/toast.dart';
import '../models/payment.dart';
import '../repository/order_repository.dart';
import '../repository/order_repository.dart' as repository;
import '../models/order_list.dart';
import '../models/order_track.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';

class OrderController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<OrderList> orders = <OrderList>[];
  ShopRatingModel shopRatingData = ShopRatingModel();
  List<OrderTrack> ordersTrack = <OrderTrack>[];
  Payment paymentData =  new Payment();
  CancelledModel cancelledData = new CancelledModel();
  OverlayEntry loader;
  OrderDetailsModel invoiceDetailsData = new OrderDetailsModel();
  OrderController() {
    loader = Helper.overlayLoader(context);
    this.listenForOrders();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> refreshFavorites() async {
    //  listenForOrders();
    //listenForFavorites(message: S.of(context).favorites_refreshed_successfuly);
  }

  void listenForOrders({String message}) async {
      final Stream<OrderList> stream = await getOrders();
    stream.listen((OrderList _order) {
      setState(() {
        orders.add(_order);
      });
      print('prodict count');
      print(orders.length);
      orders.forEach((element) {
        print(element.grand_total);
      });

    }, onError: (a) {
      print(a);
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).check_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  listenForInvoiceDetails(id){
    repository.getInvoiceDetails(id).then((value) {
      setState(() => invoiceDetailsData = value);

     print(invoiceDetailsData.addressUser.username);
    }).whenComplete(() {

    });
  }

  submitShopRating(orderId,){
        shopRatingData.buyer = currentUser.value.id;

      if(shopRatingData.rate!=null) {
        Overlay.of(context).insert(loader);
        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
        repository.updateRating(shopRatingData, orderId).then((value) {

          showToast("Your rating  is update successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S
                .of(context)
                .this_email_account_exists),
          ));
        }).whenComplete(() {
          Helper.hideLoader(loader);
        });
      } else {

        showToast("Please give your rating", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
  }

  void listenForOrdersTrack(id) async {
    final Stream<OrderTrack> stream = await getOrdersTrack(id);
    stream.listen((OrderTrack _order) {
      setState(() {
        ordersTrack.add(_order);
      });
    }, onError: (a) {
      print(a);
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).check_your_internet_connection),
      ));
    }, onDone: () {});
  }

  void listenForPaymentDetails(id) async {

      repository.PaymentDetails(id).then((value) {

        setState(() { paymentData = value; });
        print('subtotal');
         print(value.delivery_fees);
         print(paymentData.sub_total);
      }).catchError((e) {

      }).whenComplete(() {

      });
    }


  void cancelOrder() async {


      Overlay.of(context).insert(loader);
      repository.cancelledOrder(cancelledData).then((value) {
        showToast("Your cancelled reason is update successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

          Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);

      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_email_account_exists),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }
  }

