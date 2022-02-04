import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart';

class DeliveryLocation extends StatefulWidget {
  @override
  _DeliveryLocationState createState() => _DeliveryLocationState();
}

class _DeliveryLocationState extends StateMVC<DeliveryLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: Column(children: [
          SizedBox(height: 100),
          Container(
              padding: EdgeInsets.only(top: 50, left: 0, right: 0),
              width: double.infinity,
              child: Image(
                  image: AssetImage("assets/img/location.png"),
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.fill)),
          SizedBox(height: 40),
          //Text('Home delivery in 13+ cities'),
        ]),
      ),
      Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {},
            child: Container(
              color: Colors.white,
              child: Container(
                width: double.infinity,
                height: 120.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      currentUser.value.selected_address==null?
                      Text(S.of(context).where_dou_you_want_your_delivery):Text(currentUser.value.selected_address),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: Container(
                          width: double.infinity,
                          // ignore: deprecated_member_use
                          child: FlatButton(
                              onPressed: () async {
                               // Address _addressData = new Address();
                                /*Navigator.of(context).pushNamed('/Login');*/
                              /**  LocationResult result = await showLocationPicker(
                                  context,
                                  setting.value.googleMapsKey,
                                  initialCenter: LatLng(31.1975844, 29.9598339),
                                  automaticallyAnimateToCurrentLocation: true,
                                  myLocationButtonEnabled: true,
                                  layersButtonEnabled: true,
                                  resultCardAlignment: Alignment.bottomCenter,
                                );

                                _addressData.latitude = result.latLng.latitude;
                                _addressData.longitude = result.latLng.longitude;
                                _addressData.addressSelect = result.address;
                                _addressData.username = currentUser.value.name;
                                _addressData.phone = currentUser.value.phone;
                                _addressData.id = 'Home';
                                _addressData.isDefault = 'true';
                                _addressData.userId = currentUser.value.id;
                                currentUser.value.selected_address =  result.address;
                                currentUser.value.latitude = result.latLng.latitude;
                                currentUser.value.longitude = result.latLng.longitude;

                                setState(() => currentUser.value.address.add(_addressData));
                                   print(currentUser.value.toMap());
                                setCurrentUserUpdate(currentUser.value);
                                Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2); */
                              //
                              },
                              padding: EdgeInsets.all(15),
                              color:
                              Theme.of(context).colorScheme.secondary.withOpacity(1),
                              child: Text(
                                S.of(context).use_my_location,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .merge(TextStyle(color: Colors.white)),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    ]));
  }
}
