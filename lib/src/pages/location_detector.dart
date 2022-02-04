import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:multisuperstore/src/models/address.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';

class LocationDetector extends StatefulWidget {
  @override
  _LocationDetectorState createState() => _LocationDetectorState();
}

class _LocationDetectorState extends State<LocationDetector> {
  loc.Location locationR = loc.Location();

  @override
  void initState() {
    _getCurrentLocation();
  }

  checkLocation() async {
    await locationR.requestService();
    if (!await locationR.serviceEnabled()) {
      locationR.requestService();

      print('enabled location');
    } else {
      _getCurrentLocation();
    }
  }

  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   height: 220,width:220,
              //   child:FlareActor(
              //   "assets/img/location_place_holder.flr",
              //   alignment: Alignment.center,
              //   fit: BoxFit.contain,
              //   animation: "record",
              // ),),
              Container(
                height: 220,
                width: 220,
                child: Image.asset(
                  "assets/img/ic_location.gif",
                  height: 125.0,
                  width: 125.0,
                ),
              ),
              Container(
                  child: Text(
                      _currentAddress == null
                          ? 'Geolocalizzando...'
                          : 'Geolocalizzando',
                      style: TextStyle(
                        color: Theme.of(context).disabledColor.withOpacity(0.9),
                      ))),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Wrap(children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Theme.of(context).disabledColor.withOpacity(0.9),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        _currentAddress == null
                            ? 'Ottenendo la posizione'
                            : 'La Tua Posizione',
                        style: Theme.of(context).textTheme.headline3,
                      )),
                ]),
              ),

              Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    _currentAddress != null ? _currentAddress : '',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .merge(TextStyle(color: Colors.black)),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _getCurrentLocation() {
    print('location check');

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        print('get position');

        _getAddressFromLatLng(position);
      });
    }).catchError((e) {
      print(e);

      checkLocation();
    });
  }

  _getAddressFromLatLng(Position currentPosition) async {
    try {
      print('location loaded');
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = placemarks[0];
      if (placemarks[0].locality != null && placemarks[0].locality.isNotEmpty) {
        setState(() {
          _currentAddress =
              "${place.street}, ${place.subLocality}, ${place.administrativeArea},${place.postalCode}, ${place.country}";
        });
      } else {
        setState(() {
          _currentAddress =
              "${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea},${place.postalCode}, ${place.country}";
        });
      }

      Address _addressData = Address();
      if (catchLocationList.value.length == 0) {
        _addressData.addressSelect = _currentAddress;
        _addressData.latitude = currentPosition.latitude;
        _addressData.longitude = currentPosition.longitude;
        _addressData.selected = false;
        catchLocationList.value.add(_addressData);
        setCatchLocationList();
      } else {
        var contain = catchLocationList.value
            .where((element) => element.addressSelect == _currentAddress);

        _addressData.addressSelect = _currentAddress;
        _addressData.latitude = currentPosition.latitude;
        _addressData.longitude = currentPosition.longitude;
        _addressData.selected = false;
        if (contain.isEmpty) {
          catchLocationList.value.add(_addressData);
          setCatchLocationList();
        }
      }
      currentUser.value.selected_address = _addressData.addressSelect;
      currentUser.value.latitude = _addressData.latitude;
      currentUser.value.longitude = _addressData.longitude;

      print(currentUser.value.selected_address);

      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
      });
    } catch (e) {
      print('location $e');
      print(e);
      // Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    }
  }
}
