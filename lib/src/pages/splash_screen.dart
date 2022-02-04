import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _con;
  bool firstLoad = false;
  SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    _con.progress.addListener(() {
      double progress = 0;
      _con.progress.value.values.forEach((_progress) {
        progress += _progress;
        print(progress);
      });
      if (progress == 100) {
        try {
          print('loader');

          if (currentUser.value.auth != false &&
              currentUser.value.auth != null) {
            if (currentUser.value.latitude != 0.0 &&
                currentUser.value.longitude != 0.0) {
              if (firstLoad == false) {
                setState(() {
                  firstLoad = true;
                });
                //Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
                Navigator.of(context)
                    .pushReplacementNamed('/AnimatedScreen', arguments: false);
                // Navigator.of(context).pushReplacementNamed('/tutorialscreen');
              }
            } else {}
          } else {
            Navigator.of(context)
                .pushReplacementNamed('/AnimatedScreen', arguments: false);
          }
        } catch (e) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: 1 == 0
          ? Container(
              padding: EdgeInsets.only(
                top: 0,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: FlareActor(
                      "assets/img/splash.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      animation: "bottomanimi",
                    ),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/img/logo.png',
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 50),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
