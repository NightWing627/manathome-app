
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multisuperstore/src/models/coupon.dart';
import 'package:multisuperstore/src/models/product_details2.dart';
import 'package:multisuperstore/src/models/shop_type.dart';
import 'package:multisuperstore/src/models/slide.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/category.dart';

import '../repository/home_repository.dart';
import '../models/restaurant_product.dart';
import '../repository/vendor_repository.dart';
import '../models/vendor.dart';

class VendorController extends ControllerMVC {
  List<Vendor> vendorList = <Vendor>[];
  List<Category> categories = <Category>[];
  List<Slide> middleSlides = <Slide>[];
  List<ProductDetails2> productSlide = <ProductDetails2>[];
  List<RestaurantProduct> vendorResProductList = <RestaurantProduct>[];
  List<Coupon> couponList = <Coupon>[];
  List<ShopType> shopTypeList= <ShopType>[];
  String currentSuperCategory;
  VendorController() {
    //listenForCategories();

    listenForDealOfDay('first');


  }

  Future<void> listenForDealOfDay(id) async {
    setState(() => shopTypeList.clear());
    currentSuperCategory = id;
    final Stream<ShopType> stream = await getShopType(id);
    stream.listen((ShopType _type) {
      if(currentSuperCategory==_type.shopType || id == 'first') {
        setState(() => shopTypeList.add(_type));
      }
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> listenForVendorList(int shopType, int focusId) async {

    final Stream<Vendor> stream = await getVendorList(shopType, focusId);

    stream.listen((Vendor _list) {
      setState(() => vendorList.add(_list));
      vendorList.forEach((element) {
        print(element.logo);
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print('done');
    });
  }

  Future<void> listenForVendorListOffer(shopType, offerType, offer ) async {

    final Stream<Vendor> stream = await getVendorListOffer(shopType, offerType, offer);

    stream.listen((Vendor _list) {
      setState(() => vendorList.add(_list));
      vendorList.forEach((element) {
        print(element.logo);
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }



  Future<void> listenForCategories(shopId) async {
    final Stream<Category> stream = await getCategories(shopId);
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForOffers(shopId) async {
    final Stream<Coupon> stream = await getCoupons(shopId);
    stream.listen((Coupon _category) {
      setState(() => couponList.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  Future<void> listenForRestaurantProduct(int shopType) async {
    final Stream<RestaurantProduct> stream = await get_restaurantProduct(shopType);

    stream.listen((RestaurantProduct _list) {
      setState(() => vendorResProductList.add(_list));

      vendorResProductList.forEach((element) {
        print('list');
        print(element.category_name);
      });

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  sendChat(chatTxt, userId, shopId, shopMobile, shopName) {
    String chatRoom = '${DateTime.now().millisecondsSinceEpoch}$userId-$shopId';
   FirebaseFirestore.instance.collection('chatList').doc(chatRoom).set({
      'message': chatTxt.text,
      'userId': userId,
      'shopId': shopId,
      'senderName': currentUser.value.name,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'transferType': 'User'
    }).catchError((e) {
      print(e);
    });
    String chatMaster = 'U$userId-F$shopId';
    FirebaseFirestore.instance.collection('chatUser').doc(chatMaster).set(
      {
        'shopId': shopId,
        'userId': userId,
        'lastChat': chatTxt.text,
        'shopMobile': shopMobile,
        'shopunRead': 'false',
        'userMobile': currentUser.value.phone,
        'userName': currentUser.value.name,
        'shopName': shopName,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'transferType': 'User',
        'phone': 9675087369,
      },
    ).catchError((e) {
      print(e);
    });

    return true;

}

  Future<void> listenForMiddleSlides(id) async {
    final Stream<Slide> stream = await getSlides(id);
    stream.listen((Slide _slide) {
      setState(() => middleSlides.add(_slide));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForMiddleSlidesVideo(id) async {
    final Stream<Slide> stream = await getVendorSlides(id);
    stream.listen((Slide _slide) {
      setState(() => middleSlides.add(_slide));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }



  void listenForFavoritesShop() async {
    final Stream<Vendor> stream = await getFavoritesShop();
    stream.listen((Vendor _favorite) {
      setState(() {
        vendorList.add(_favorite);
      });
    }, onError: (a) {
      // ignore: deprecated_member_use

    }, onDone: () {

    });
  }

  void listenForVendorSlide({String id}) async {
    final Stream<ProductDetails2> stream = await getShopProductSlide(id);
    stream.listen((ProductDetails2 _list) {
      setState(() {
        productSlide.add(_list);
      });
    }, onError: (a) {
      // ignore: deprecated_member_use

    }, onDone: () {

    });
  }

}
