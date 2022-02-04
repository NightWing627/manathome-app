import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/user_controller.dart';
import 'dart:math';
class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends StateMVC<Register> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  UserController _con;
  _RegisterState() : super(UserController()) {
    _con = controller;
  }
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
      key: _con.scaffoldKey,
      body: Stack(

        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/loginbg1.jpg'), fit: BoxFit.cover)),
          ),

          Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xff161d27).withOpacity(0.9),
                  Color(0xff161d27),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Positioned(
            top: 50.0,
            right: size.width * -0.24,
            child:Container(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: animationController,
                child: Container(
                  child: Image(
                    image: AssetImage('assets/img/plate-food2.png'),

                    height:size.width * 0.5,
                    fit: BoxFit.fill,

                  ),
                ),
                builder: (BuildContext context, Widget _widget) {
                  return Transform.rotate(
                    angle: animationController.value * 2 * pi,
                    child: _widget,
                  );
                },
              ),


            ),
          ),
    Form(
    key: _con.loginFormKey,
         child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).welcome,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "to ${setting.value.appName}, let's Login in",
                          style:Theme.of(context).textTheme.headline1.merge(TextStyle(color:Colors.grey))
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          width: double.infinity,
                          child: TextFormField(
                              textAlign: TextAlign.left,
                              autocorrect: true,
                              onSaved: (input) => _con.register_data.name = input,
                              validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                              style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: S.of(context).full_name,
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

                      Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          width: double.infinity,
                          child: TextFormField(
                              textAlign: TextAlign.left,
                              autocorrect: true,
                              onSaved: (input) => _con.register_data.email_id = input,
                              validator: (input) => !input.contains('@') ? S.of(context).invalid_email_format : null,
                              style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText:  S.of(context).email,
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

                      Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          width: double.infinity,

                          child: TextFormField(
                              textAlign: TextAlign.left,
                              autocorrect: true,
                              onSaved: (input) => _con.register_data.phone = input,
                              validator: (input) => input.length <= 0 ? S.of(context).invalid_mobile_number : null,
                              style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                labelText: S.of(context).mobile,
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

                      Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          width: double.infinity,
                          child: TextFormField(
                              textAlign: TextAlign.left,
                              autocorrect: true,
                              onSaved: (input) => _con.register_data.password = input,
                              validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                              style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText:S.of(context).password,
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
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children:[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 45,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 40, right: 40),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {
                            _con.register();
                          },
                          color: Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                              S.of(context).register,
                              style:Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorLight,fontWeight: FontWeight.bold,))

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
                            "${S.of(context).already_have_an_account} ?",
                            style: TextStyle(color: Theme.of(context).primaryColorLight),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushReplacementNamed('/Login');
                            },
                            child: Text(
                              "Login",
                              style:
                              TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold),
                            )
                          )

                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]
                  )
                )





              ],
            ),
          ),
    ),
        ],
      ),
    );
  }


}
