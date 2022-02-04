import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class PermissionDeniedWidget extends StatefulWidget {
  PermissionDeniedWidget({
    Key key,
  }) : super(key: key);

  @override
  _PermissionDeniedWidgetState createState() => _PermissionDeniedWidgetState();
}

class _PermissionDeniedWidgetState extends State<PermissionDeniedWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: 700,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [

                Image(
                  image: AssetImage(
                    'assets/img/permission.png',
                  ),
                  height: 150,
                  width: 500,
                ),
              ])),

            ],
          ),
          Opacity(
            opacity: 0.4,
            child: Text(
              S.of(context).you_must_sign_in_to_access_to_this_section,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3.merge(TextStyle(fontWeight: FontWeight.w300)),
            ),
          ),
          SizedBox(height: 20),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/Login');
            },
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
            color: Theme.of(context).accentColor,
            shape: StadiumBorder(),
            child: Text(
              S.of(context).login,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
            ),
          ),
          SizedBox(height: 20),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/register');
            },
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
            shape: StadiumBorder(),
            child: Text(
              S.of(context).dont_have_an_account,
              style: TextStyle(color: Theme.of(context).focusColor),
            ),
          ),
        ],
      ),
    );
  }
}
