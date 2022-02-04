import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/bookingmodel.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'dart:async';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class HThankyou extends StatefulWidget {
  HThankyou({Key key, this.orderId}) : super(key: key);
  String orderId;
  @override
  HThankyouState createState() => new HThankyouState();
}

class HThankyouState extends State<HThankyou> with SingleTickerProviderStateMixin {
  // AudioPlayer advancedPlayer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
    //loadMusic();

  }



  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {

      clearData();
      Navigator.of(context).pushReplacementNamed('/H_MyBooking');

  }
  clearData(){

    currentBookDetail.value = new BookingModel();



  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.3),
              child: Text(
                S.of(context).thank_you,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            FlareActor("assets/img/SuccessCheck.flr", alignment: Alignment.center, fit: BoxFit.contain, animation: "Untitled"),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.7),
              child: Text(
                S.of(context).your_services_booked_successfully,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
