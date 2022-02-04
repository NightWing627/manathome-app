import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:multisuperstore/src/repository/settings_repository.dart';
import 'package:toast/toast.dart';
import '../models/timeslot.dart';
import '../helpers/helper.dart';
import '../models/checkout.dart';
import '../repository/user_repository.dart';
import '../models/coupons.dart';

import '../repository/order_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/product_repository.dart';

class CartController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  int cartCount = 0;
  List<Coupons> couponList = <Coupons>[];
  List<TimeSlot> timeSlot = <TimeSlot>[];


  GlobalKey<ScaffoldState> scaffoldCheckout;
  bool couponStatus;
  OverlayEntry loader;
  CartController() {
    this.scaffoldCheckout = new GlobalKey<ScaffoldState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    loader = Helper.overlayLoader(context);
  }

  @override
  void initState() {
    // settingRepo.initSettings();

    super.initState();
    currentCheckout.value.delivery_fees = Helper.calculateDeliveryFees().toDouble();
  }

  listenForCartsCount() async {
    setState(() => cartCount = currentCart.value.length);
  }

  calculateAmount() {

    double totalprice = 0;

    double addon =0;

    currentCart.value.forEach((element) {
      element.addon.forEach((addonElement) {
        addon += double.parse(addonElement.price)* element.qty;
      });
      totalprice += (double.parse(element.price) * element.qty)+ addon;
      //int totalstrickprice = 0;
      //totalstrickprice += int.parse(element.strike) * element.qty;


    });
    //int saveamount;
    //saveamount = totalstrickprice - totalprice;

    return totalprice;
  }

  decrementQty(id, variantId) {
    bool removeState;
    currentCart.value.forEach((element) {
      if (element.id == id && element.variant == variantId) {
        if (element.qty > 1) {
          element.qty = element.qty - 1;
        } else {
          removeState = true;
        }
      }
    });
    if (removeState == true) {
      currentCart.value.removeWhere((item) => item.id == id && item.variant  == variantId);
    }
    currentCheckout.value.couponCode = '';
    currentCheckout.value.couponStatus = false;
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    grandSummary();
    setCurrentCartItem();
    if (currentCart.value.length == 0) {
      currentCheckout.value.shopName = null;
      currentCheckout.value.shopTypeID = 0;
      currentCheckout.value.shopId = null;
      Navigator.of(context).pushReplacementNamed('/EmptyList');
    }
  }

  showQty(id, variantID) {
    String qty;
    currentCart.value.forEach((element) {
      if (element.id == id && element.variant==variantID) {
        qty = element.qty.toString();
      }
    });
    return qty;
  }

  incrementQty(id, variantId) {
    currentCart.value.forEach((element) {
      if (element.id == id && element.variant == variantId) {
        element.qty = element.qty + 1;
      }
    });
    currentCheckout.value.couponCode = '';
    currentCheckout.value.couponStatus = false;
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    grandSummary();
    setCurrentCartItem();
  }



  grandSummary() {
    double saveamount = 0;
    double totalprice = 0;
    double totalsalesprice = 0;
    double tax =0;
    double addon =0;

    currentCart.value.forEach((element) {
      totalprice += double.parse(element.price) * element.qty;
      tax += element.tax * element.qty;


      totalsalesprice += double.parse(element.price) * element.qty;
      element.addon.forEach((addonElement) {
        addon += double.parse(addonElement.price)* element.qty;
      });

    });

    saveamount = num.parse(totalsalesprice.toStringAsFixed(2)) -  num.parse(totalprice.toStringAsFixed(2));
    currentCheckout.value.sub_total = num.parse((totalsalesprice +addon).toStringAsFixed(2));
    currentCheckout.value.discount = saveamount;
    currentCheckout.value.tax = tax;
    currentCheckout.value.payment.tax = tax;
    couponStatus = currentCheckout.value.couponStatus;
    if (currentCheckout.value.couponStatus == false) {
      currentCheckout.value.grand_total = num.parse((totalprice + addon+  currentCheckout.value.delivery_tips + currentCheckout.value.delivery_fees  +tax).toStringAsFixed(2));
    }
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    Future.delayed(Duration.zero, () async {
      currentCart.notifyListeners();
    });

    return saveamount;
  }



  redirect() {
    if (currentCart.value.length == 0) {
      Navigator.of(context).pushReplacementNamed('/EmptyList');
    }
  }

  Future<void> listenForCoupons() async {
    final Stream<Coupons> stream = await getCoupon();
    stream.listen((Coupons _coupons) {
      setState(() => couponList.add(_coupons));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  applyCoupon(code, discountType, double discountValue) {
    double totalprice = 0;
    double discountAmount = 0;
    currentCart.value.forEach((element) {
      totalprice += double.parse(element.price) * element.qty;
    });

    if (discountType == 'amount') {
      currentCheckout.value.grand_total = totalprice - discountValue;
    } else {
      discountAmount = ((totalprice * discountValue) / 100);
      currentCheckout.value.discount = currentCheckout.value.discount + discountAmount;
      currentCheckout.value.grand_total = (totalprice - discountAmount) ;
      showToast("Your Coupon is applied successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);


    }
    currentCheckout.value.couponCode = code;
    currentCheckout.value.couponStatus = true;

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    currentCart.notifyListeners();

    Navigator.pop(context, currentCheckout.value.couponStatus);
  }

  removeCoupon() {
    currentCheckout.value.couponCode = '';
    currentCheckout.value.couponStatus = false;
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    currentCart.notifyListeners();

    setState(() => couponStatus = false);
    showToast("Your Coupon is removed successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);


  }

  clearCart(){
    currentCart.value.clear();
    currentCheckout.value = new Checkout();
    setCurrentCartItem();
  }

  void gotopayment() {
    currentCheckout.value.address.addressSelect = currentUser.value.selected_address;
    currentCheckout.value.address.userId = currentUser.value.id;
    currentCheckout.value.address.phone = currentUser.value.phone;
    currentCheckout.value.address.username = currentUser.value.name;
    currentCheckout.value.userId = currentUser.value.id;
    currentCheckout.value.address.longitude = currentUser.value.longitude;
    currentCheckout.value.address.latitude = currentUser.value.latitude;

    currentCheckout.value.cart = currentCart.value;
    if (currentUser.value.selected_address == null) {
      showToast("Please select your address", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

    } else {
      if(currentCheckout.value.deliverType==1 || currentCheckout.value.deliverType==3) {
        if (currentCheckout.value.deliveryTimeSlot == null || currentCheckout.value.deliveryTimeSlot == '') {
          showToast("Please select your deliver time slot", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

        } else {

          if(currentCheckout.value.uploadImage=='no') {
            Navigator.of(context).pushNamed('/Payment');
          }else {
            bookOrder(currentCheckout.value);
          }
        }


        // currentCheckout.value.deliveryTimeSlot = '';

      }else if (currentCheckout.value.deliveryTimeSlot == null || currentCheckout.value.deliveryTimeSlot == '') {
        showToast("Please select your deliver time slot", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

      } else {


        if(currentCheckout.value.uploadImage=='no') {
          Navigator.of(context).pushNamed('/Payment');
        } else {
          bookOrder(currentCheckout.value);
        }
      }
    }
  }



  void bookOrder(Checkout order) {
    order.saleCode = '${DateTime.now().millisecondsSinceEpoch}${currentUser.value.id}';




    FirebaseFirestore.instance
        .collection('orderDetails')
        .doc(order.saleCode)
        .set({'status': 'Placed', 'userId': currentUser.value.id, 'orderId': order.saleCode, 'shopId': order.shopId,'userName': currentUser.value.name,
      'originLatitude': currentUser.value.latitude, 'originLongitude': currentUser.value.longitude, 'shopLatitude': double.tryParse(currentCheckout.value.shopLatitude),
      'shopLongitude': double.tryParse(currentCheckout.value.shopLongitude),'shopName':currentCheckout.value.shopName}).catchError((e) {
      print(e);
    });
    Overlay.of(context).insert(loader);
    bookOrderResp().then((value) {
      if(order.uploadImage!='no') {
        sendImage(order.uploadImage, value);
      }
      print('check payment type');
      print(currentCheckout.value.payment.paymentType);
      if(currentCheckout.value.payment.paymentType=='wallet'){
        currentUser.value.walletAmount = (double.parse(currentUser.value.walletAmount) - currentCheckout.value.payment.grand_total).toString();
        print(currentUser.value.walletAmount);
        setCurrentUserUpdate(currentUser.value);
      }




      Navigator.of(context).pushNamed('/Thankyou', arguments: value);
    }).catchError((e) {
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(e),
      ));
    }).whenComplete(() {
      Helper.hideLoader(loader);
      //refreshOrders();
      /** scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).orderThisorderidHasBeenCanceled(order.id)),
          )); */
    });
  }

  void sendImage(File image, saleCode) async {


    final String _apiToken = 'api_token=${currentUser.value.apiToken}';
    // ignore: deprecated_member_use
    final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api/sendimage/${currentUser.value.id}/$saleCode?$_apiToken");
    var request = http.MultipartRequest('POST', uri);
    var pic = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      // Navigator.of(context).pushReplacementNamed('/Success');

    } else {}
  }



  getTimeSlot() async {
    final Stream<TimeSlot> stream = await getTimeSlotData();
    stream.listen((TimeSlot _timeSlot) {
      setState(() => timeSlot.add(_timeSlot));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  calculateDistance(lat1, lon1,lat2,lon2){
    double distance = Helper.distance(lat1, lon1, double.parse(lat2), double.parse(lon2), 'K');
    print(distance);
    print(setting.value.coverDistance);
    if(distance<setting.value.coverDistance){
      currentCheckout.value.deliveryPossible = true;
    } else {
      currentCheckout.value.deliveryPossible = false;
    }
    print(currentCheckout.value.deliveryPossible);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    currentCart.notifyListeners();
  }


  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

}
