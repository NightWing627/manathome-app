import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multisuperstore/src/models/providerlist.dart';
import 'package:multisuperstore/src/models/shop_type.dart';
import 'package:multisuperstore/src/models/vendor.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import '../repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';




import '../helpers/helper.dart';
import '../models/address.dart';
import '../repository/market_repository.dart';


class MapController extends ControllerMVC {

  List<Vendor> topMarkets = <Vendor>[];
  List<ProviderList> providerList = <ProviderList>[];
  List<Marker> allMarkers = <Marker>[];
  List<Marker> allProviderMarkers = <Marker>[];
  Address currentAddress;
  Set<Polyline> polylines = new Set();
  List<ShopType> shopTypeList= <ShopType>[];
  CameraPosition cameraPosition;
  // MapsUtil mapsUtil = new MapsUtil();
  Completer<GoogleMapController> mapController = Completer();

  void listenForNearMarkets(Address myLocation, Address areaLocation) async {
    final Stream<Vendor> stream = await getNearMarkets(myLocation, areaLocation,'');
    stream.listen((Vendor _market) {
      // Helper.calculateDistance();


      setState(() {
        if (_market.logo != null) {
          topMarkets.add(_market);
        }
      });
      Helper.getMarker(_market.toMap()).then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });
    }, onError: (a) {}, onDone: () {});
  }

  void listenForNearMarketsWithID(Address myLocation, Address areaLocation, id) async {
    setState(() {
      topMarkets.clear();
    });

    final Stream<Vendor> stream = await getNearMarkets(myLocation, areaLocation,id);
    stream.listen((Vendor _market) {
      // Helper.calculateDistance();


      setState(() {
        if (_market.logo != null) {
          topMarkets.add(_market);
        }
      });
      Helper.getMarker(_market.toMap()).then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });
    }, onError: (a) {}, onDone: () {});
  }

  void getCurrentLocation() async {
    try {

      setState(() {

        cameraPosition = CameraPosition(
          target: LatLng(currentUser.value.latitude, currentUser.value.longitude),
          zoom: 14.4746,
        );

      });

      Helper.getMyPositionMarker(currentUser.value.latitude,currentUser.value.longitude).then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }



  void getCurrentProviderLocation() async {
    try {

      setState(() {

        cameraPosition = CameraPosition(
          target: LatLng(currentUser.value.latitude, currentUser.value.longitude),
          zoom: 14.4746,
        );

      });

      Helper.getMyPositionMarker(currentUser.value.latitude,currentUser.value.longitude).then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }

  void getMarketLocation() async {
    try {

      setState(() {
        cameraPosition = CameraPosition(
          target: LatLng(currentUser.value.latitude, currentUser.value.longitude),
          zoom:  17.5,
        );
      });
      Helper.getMyPositionMarker(currentUser.value.latitude, currentUser.value.longitude).then((marker) {
        setState(() {
          allMarkers.add(marker);
        });
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }

  void getProvider() async {
    setState(() {
      providerList = <ProviderList>[];
      Address areaAddress = Address.fromJSON({"latitude": currentBookDetail.value.latitude, "longitude": currentBookDetail.value.longitude});
      if (cameraPosition != null) {
        listenForNearProvider(currentAddress, areaAddress);
      } else {
        listenForNearProvider(currentAddress, currentAddress);
      }
    });
  }

  void listenForNearProvider(Address myLocation, Address areaLocation) async {
    final Stream<ProviderList> stream = await getNearProvider(myLocation, areaLocation);
    stream.listen((ProviderList _market) {
      // Helper.calculateDistance();

      setState(() {
        if (_market.name != null) {

          providerList.add(_market);
        }
      });

      Helper.getMarkerProvider(_market.toMap()).then((marker) {
        setState(() {
          allProviderMarkers.add(marker);
        });
      });
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> goCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;



    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentUser.value.latitude,currentUser.value.longitude),
      zoom: 14.4746,
    )));

  }

  void getMarketsOfArea() async {
    setState(() {
      topMarkets = <Vendor>[];
      Address areaAddress = Address.fromJSON({"latitude": currentUser.value.latitude, "longitude": currentUser.value.longitude});
      if (cameraPosition != null) {
        listenForNearMarkets(currentAddress, areaAddress);
      } else {
        listenForNearMarkets(currentAddress, currentAddress);
      }
    });
  }

  /*
  void getDirectionSteps() async {
    currentAddress = await sett.getCurrentLocation();
    mapsUtil
        .get("origin=" +
            currentAddress.latitude.toString() +
            "," +
            currentAddress.longitude.toString() +
            "&destination=" +
            currentMarket.latitude +
            "," +
            currentMarket.longitude +
            "&key=${sett.setting.value?.googleMapsKey}")
        .then((dynamic res) {
      if (res != null) {
        List<LatLng> _latLng = res as List<LatLng>;
        _latLng?.insert(0, new LatLng(currentAddress.latitude, currentAddress.longitude));
        setState(() {
          polylines.add(new Polyline(
              visible: true,
              polylineId: new PolylineId(currentAddress.hashCode.toString()),
              points: _latLng,
              color: config.Colors().mainColor(0.8),
              width: 6));
        });
      }
    });
  }
 */
  Future refreshMap() async {
    setState(() {
      topMarkets = <Vendor>[];
    });
    //  listenForNearMarkets(currentAddress, currentAddress);
  }

  Future<void> listenForShopType() async {
    final Stream<ShopType> stream = await getShopType();
    stream.listen((ShopType _type) {
      setState(() => shopTypeList.add(_type));
    }, onError: (a) {}, onDone: () {
      print('shoptype');
      print(shopTypeList.length);
    });
  }


}
