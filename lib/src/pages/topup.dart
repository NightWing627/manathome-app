import 'package:flutter/material.dart';
import 'package:multisuperstore/src/components/light_color.dart';
import 'package:multisuperstore/src/components/title_text.dart';
import 'package:multisuperstore/src/controllers/wallet_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class TopUpPage extends StatefulWidget {
  TopUpPage({Key key}) : super(key: key);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends StateMVC<TopUpPage> {
  final TextEditingController textEditingController = TextEditingController();
  WalletController _con;
  _TopUpPageState() : super(WalletController()) {
    _con = controller;
  }
  var _value = "";
  Align _buttonWidget() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: MediaQuery.of(context).size.height * .48,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    children: <Widget>[
                      _countButton("1"),
                      _countButton("2"),
                      _countButton("3"),
                      _countButton("4"),
                      _countButton("5"),
                      _countButton("6"),
                      _countButton("7"),
                      _countButton("8"),
                      _countButton("9"),
                      _icon(Icons.arrow_back_ios_sharp,false),
                      _countButton("0"),
                      _icon(Icons.backspace, false),
                    ],
                  ),
                ),
                _transferButton()
              ],
            )));
  }
  setText(String value) async {


    setState(() {
      _value += value;
      textEditingController.text = _value;
    });
  }

  Widget _transferButton() {
    return InkWell(
      onTap: (){
         _con.recharge(textEditingController.text);
        //_con.showToast("This is demo version", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Wrap(
            children: <Widget>[
              Transform.rotate(
                angle: 70,
                child: Icon(
                  Icons.swap_calls,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              TitleText(
                text: "Transfer",
                color: Colors.white,
              ),
            ],
          )),
    );
  }

  Widget _icon(IconData icon, bool isBackground) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: (){
                if (_value != null && _value.length > 0) {
                  setState(() {
                    _value = _value.substring(0, _value.length - 1);
                    textEditingController.text = _value;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: isBackground
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Icon(icon),
              ),
            ),

          ],
        ));
  }

  Widget _countButton(String text) {
    return Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
            onTap: () {
              setText(text);
            },
            child: Container(
              alignment: Alignment.center,
              color: Theme.of(context).primaryColor,
              child: Text(
                text,style:Theme.of(context).textTheme.headline4
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        backgroundColor: Color(0xFF15294a),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'TopUp your wallet',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 210,
                        padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: LightColor.navyBlue2,
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                            enabled: false,
                         controller:  textEditingController,
                         style:Theme.of(context).textTheme.headline5.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                        )),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
              Positioned(
                left: -140,
                top: -270,
                child: CircleAvatar(
                  radius: 190,
                  backgroundColor: LightColor.lightBlue2,
                ),
              ),
              Positioned(
                left: -130,
                top: -300,
                child: CircleAvatar(
                  radius: 190,
                  backgroundColor: LightColor.lightBlue1,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .4,
                right: -150,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow2,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .4,
                right: -180,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow,
                ),
              ),
              Positioned(
                  left: 0,
                  top: 40,
                  child: Row(
                    children: <Widget>[
                      BackButton(color: Colors.white,),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: (){


                        },
                        child: TitleText(
                          text: "Transfer",
                          color: Colors.white,
                        ),
                      )
                    ],
                  )),
              _buttonWidget(),
            ],
          ),
        ));
  }
}