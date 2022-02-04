
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/address.dart';
import 'package:multisuperstore/src/models/hstatusmanager.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/hsubcategory.dart';
class HServiceController extends ControllerMVC {
  List<HSubcategory> subcategory = <HSubcategory>[];
  List<HSubcategory> category = <HSubcategory>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<ScaffoldState> timescaffoldKey;
  OverlayEntry loader;
  Address addressData = Address();
  HServiceController() {
    loader = Helper.overlayLoader(context);
    this.timescaffoldKey = new GlobalKey<ScaffoldState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }


  Future<void> listenForSubcategories(id) async {
    final Stream<HSubcategory> stream = await getSubcategories(id);
    stream.listen((HSubcategory _subcategory) {
      if (_subcategory.id != null) {
        setState(() => subcategory.add(_subcategory));
      }
    }, onError: (a) {
      print(a);
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Verify your internet connection'),
      ));
    }, onDone: () {});
  }

  Future<void> listenForCategories() async {
    final Stream<HSubcategory> stream = await getCategories();
    stream.listen((HSubcategory _category) {
      if (_category.id != null) {
        setState(() => category.add(_category));
      }
    }, onError: (a) {
      print(a);
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Verify your internet connection'),
      ));
    }, onDone: () {});
  }


  void gotoMap(){

    if(currentBookDetail.value.address!=null) {

      Navigator.of(context).pushNamed('/mapH');
    }else{
      // ignore: deprecated_member_use
      timescaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Please select your address'),
      ));
    }
  }

  gotoBooking(String categoryId,String subCategoryId, String name, String img ){
    currentBookDetail.value.categoryId = categoryId;
    currentBookDetail.value.subcategoryId = subCategoryId;
    currentBookDetail.value.subcategoryName = name;
    currentBookDetail.value.subcategoryImg = img;
    Navigator.of(context)
        .pushNamed('/H_schedule');
  }
// ignore: non_constant_identifier_names
  void book_firebase() async {
    Overlay.of(context).insert(loader);
    currentBookDetail.value.bookingTime = DateTime.now().millisecondsSinceEpoch;
    currentBookDetail.value.status = 'pending';
    currentBookDetail.value.username = currentUser.value.name;
    currentBookDetail.value.userMobile = currentUser.value.phone;
    currentBookDetail.value.userid    = currentUser.value.id;
    String bookId = 'U${currentBookDetail.value.userid}D${DateTime.now().millisecondsSinceEpoch.toString()}';
    currentBookDetail.value.bookId = bookId;
    currentBookDetail.value.userRatingStatus = 'no';
    currentBookDetail.value.providerRatingStatus = 'no';

   final databaseReference = FirebaseFirestore.instance;
   await databaseReference.collection("HService").doc(bookId).set(currentBookDetail.value.toMap());

    StatusManager _status = new StatusManager();
    _status.serviceBooked = true;
    _status.bookId = bookId;
    _status.serviceBooked = true;
    _status.serviceBookedTime = DateTime.now().millisecondsSinceEpoch;
   final databaseReferenceTrack = FirebaseFirestore.instance;
   await databaseReferenceTrack.collection("HStatusManager").doc(bookId).set(_status.toMap());

    bookOrdered();
  }

  void bookOrdered() {
    bookOrderData(1).then((value) {
      Navigator.of(context).pushReplacementNamed('/HThankyou');

    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(e),
      ));
    }).whenComplete(() {
      //refreshOrders();
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Your order is booked'),
      ));
    });
  }

}
