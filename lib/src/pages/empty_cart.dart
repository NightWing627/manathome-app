import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class EmptyList extends StatefulWidget {
  @override
  _EmptyListState createState() => _EmptyListState();
}

class _EmptyListState extends State<EmptyList> {
  int dropDownValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image(
            image: AssetImage(
              'assets/img/cart_empty_ipmau1.png',
            ),
            height: 200,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text(
            S.of(context).no_items_in_your_cart,
            style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15, left: 30, right: 30),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              S.of(context).your_favourite_items_are_just_a_click_away,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ),
        SizedBox(height: 30),
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
          },
          shape: Border.all(width: 2.0, color: Theme.of(context).hintColor),
          padding: EdgeInsets.all(15),
          child: Text(
            S.of(context).go_to_home,
            style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Theme.of(context).backgroundColor, fontWeight: FontWeight.w600)),
          ),
        )
      ],
    )));
  }
}
