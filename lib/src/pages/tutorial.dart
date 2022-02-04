import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/user_repository.dart';
import '../controllers/splash_screen_controller.dart';

class TutorialScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TutorialScreenState();
  }
}

class TutorialScreenState extends StateMVC<TutorialScreen> {
  TutorialScreenState() : super() {}

  bool isFirstLoad = false;

  @override
  void initState() {
    super.initState();
  }

  void loadData() {
    try {
      print('loader');

      if (currentUser.value.auth != false && currentUser.value.auth != null) {
        if (currentUser.value.latitude != 0.0 &&
            currentUser.value.longitude != 0.0) {
          if (isFirstLoad == false) {
            setState(() {
              isFirstLoad = true;
            });
            //Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);

            // Navigator.of(context).pushReplacementNamed('/tutorialscreen');
          }
        } else {}
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _con.scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Image.asset(
                "assets/img/bg_tuto.png",
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.width * 504 / 881,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/img/ic_map.png",
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                        ),
                        Text(
                          'SELEZIONA LA TUA CITTA',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: 16),
                        ),
                        Text(
                          'scopri i servizi disponibili',
                          style: TextStyle(
                              color: Color.fromRGBO(0xF5, 0x84, 0x31, 1.0),
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              fontSize: 14),
                        )
                      ],
                    )
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/img/ic_ordina.png",
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                        ),
                        Text(
                          'ORDINA',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: 16),
                        ),
                        Text(
                          'i tuoi piatti preferiti',
                          style: TextStyle(
                              color: Color.fromRGBO(0xF5, 0x84, 0x31, 1.0),
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              fontSize: 14),
                        )
                      ],
                    )
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/img/ic_ricevilo.png",
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                        ),
                        Text(
                          'RICEVI TUTTO',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: 16),
                        ),
                        Text(
                          'comodamente a casa tua!',
                          style: TextStyle(
                              color: Color.fromRGBO(0xF5, 0x84, 0x31, 1.0),
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'oppure',
                          style: TextStyle(
                              color: Color.fromRGBO(0xF5, 0x84, 0x31, 1.0),
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              fontSize: 14),
                        ),
                      ],
                    )
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/img/ic_contatta.png",
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                        ),
                        Text(
                          'CONTATTA E PRENOTA',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: 16),
                        ),
                        Text(
                          'i professioisti di cui hai bisogno',
                          style: TextStyle(
                              color: Color.fromRGBO(0xF5, 0x84, 0x31, 1.0),
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              fontSize: 14),
                        )
                      ],
                    )
                  ],
                )),
            // SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                if (isFirstLoad) {
                  Navigator.of(context).pushNamed('/introscreen');
                } else {
                  Navigator.of(context).pushNamed('/location');
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/img/btn_avanti.png",
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width / 3,
                            height:
                                MediaQuery.of(context).size.width * 131 / 366,
                          ),
                        ],
                      )
                    ],
                  )),
            ),

            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
