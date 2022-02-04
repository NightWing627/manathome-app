import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/repository/settings_repository.dart';
import 'package:multisuperstore/src/social_login/facebook.dart';
import 'package:multisuperstore/src/social_login/google.dart';
import '../../generated/l10n.dart';
import 'package:multisuperstore/src/controllers/user_controller.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart' as _firebase_auth;

import 'package:mvc_pattern/mvc_pattern.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage>
    with SingleTickerProviderStateMixin {
  UserController _con;
  _LoginPageState() : super(UserController()) {
    _con = controller;
  }
  AnimationController animationController;
  void initState() {
    super.initState();

    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 10),
    );

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _con.scaffoldKeyState,
      body: Stack(
        children: <Widget>[
          Image.asset('assets/img/bg_tuto.png'),
          //
          //Container(
          //  decoration: BoxDecoration(
          //      gradient: LinearGradient(colors: [
          //    Colors.transparent,
          //    Colors.transparent,
          //    Color(0xff161d27).withOpacity(0.9),
          //    Color(0xff161d27),
          //  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          //),
          //Positioned(
          //top: 50.0,
          //right: size.width * -0.24,
          //child: Container(
          //alignment: Alignment.center,
          //child: AnimatedBuilder(
          //animation: animationController,
          //child: Container(
          //child: Image(
          //image: AssetImage('assets/img/plate-food2.png'),
          //height: size.width * 0.5,
          //fit: BoxFit.fill,
          //),
          //),
          //builder: (BuildContext context, Widget _widget) {
          //return Transform.rotate(
          //angle: animationController.value * 2 * pi,
          //child: _widget,
          //);
          //},
          //),
          //),
          //),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Form(
                  key: _con.loginFormKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          S.of(context).welcome,
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 38,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("to ${setting.value.appName}, let's Login in",
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .merge(TextStyle(color: Colors.grey))),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 40, right: 40),
                            width: double.infinity,
                            child: TextFormField(
                                textAlign: TextAlign.left,
                                autocorrect: true,
                                onSaved: (input) => _con.user.email = input,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .merge(TextStyle(color: Colors.black)),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: S.of(context).email,
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .merge(TextStyle(color: Colors.grey)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColorDark,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColorDark,
                                      width: 1.0,
                                    ),
                                  ),
                                ))),
                        SizedBox(height: 3),
                        Container(
                            margin: EdgeInsets.only(left: 40, right: 40),
                            width: double.infinity,
                            child: TextFormField(
                                textAlign: TextAlign.left,
                                autocorrect: true,
                                onSaved: (input) => _con.user.password = input,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .merge(TextStyle(color: Colors.black)),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: S.of(context).password,
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .merge(TextStyle(color: Colors.grey)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColorDark,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColorDark,
                                      width: 1.0,
                                    ),
                                  ),
                                ))),
                        SizedBox(
                          height: 12,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/ForgetPassword');
                          },
                          child: Text(S.of(context).forget_password,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .merge(TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 40, right: 40),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {
                                _con.login();
                              },
                              color: Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(S.of(context).login,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .merge(TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 40, right: 40),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () async {
                                Map user = await signInWithFacebook();
                                _con.register_data.email_id = user['email'];
                                _con.register_data.password = user['uid'];
                                _con.register_data.phone = user['phoneNumber'];
                                _con.register_data.name = user['displayName'];
                                _con.register(redirect: false);

                                // _con.user.email = user.user.email;
                                // _con.user.password = user.user.uid;

                                // _con.notifyListeners();
                                // print(_con.user.toMap());
                                // _con.login(redirect: false);
                              },
                              color: Colors.blue[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text('Accedi con Meta',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .merge(TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 40, right: 40),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () async {
                                Map<String, dynamic> user =
                                    await signInWithGoogle();
                                _con.register_data.email_id = user['email'];
                                _con.register_data.password = user['uid'];
                                _con.register_data.phone = user['phoneNumber'];
                                _con.register_data.name = user['displayName'];
                                _con.register(redirect: false);

                                // _con.user.email = user.user.email;
                                // _con.user.password = user.user.uid;

                                // _con.notifyListeners();
                                // print(_con.user.toMap());
                                // _con.login(redirect: false);
                              },
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text('Accedi con Google',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .merge(TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "It's your first time here?",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/register');
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
