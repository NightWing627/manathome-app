import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coupon_curveoffer.dart';

class CouponsWidget extends StatefulWidget {
  @override
  _CouponsWidgetState createState() => _CouponsWidgetState();
}

class _CouponsWidgetState extends State<CouponsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: choices.length,
          padding: EdgeInsets.only(right: 20),
          itemBuilder: (context, index) {
            return ClipperContainer(choice: choices[index]);
          }),
    );
  }
}

class ClipperContainer extends StatelessWidget {
  const ClipperContainer({Key key, this.choice}) : super(key: key);
  final ClipperContainerListItem choice;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: MultipleRoundedCurveClipper(),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 0),
                child: Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width / 2.6,
                  decoration: BoxDecoration(
                      //color: Colors.deepOrangeAccent.withOpacity(0.3),
                      image: new DecorationImage(
                        image: new AssetImage("assets/img/poper.png"),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 1)],
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))),
                  child: Center(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 9),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepOrangeAccent,
                      ),
                      width: 50.0,
                      height: 50.0,
                      child: Image(
                        image: AssetImage(choice.icon),
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(choice.title, style: (TextStyle(color: Colors.deepOrange))),
                    Text(choice.subtitle, style: Theme.of(context).textTheme.headline1),
                    Text(choice.offer, style: Theme.of(context).textTheme.headline1)
                  ])),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ClipperContainerListItem {
  const ClipperContainerListItem({this.title, this.icon, this.subtitle, this.offer});
  final String title;
  final String icon;
  final String subtitle;

  final String offer;
}

const List<ClipperContainerListItem> choices = const <ClipperContainerListItem>[
  const ClipperContainerListItem(
    title: 'FREE DISH',
    icon: 'assets/img/clock.png',
    subtitle: 'BUY 2',
    offer: 'GET 1 FREE',
  ),
  const ClipperContainerListItem(
    title: 'FREE DISH',
    icon: 'assets/img/clock.png',
    subtitle: 'BUY 2',
    offer: 'GET 1 FREE',
  ),
  const ClipperContainerListItem(
    title: 'FREE DISH',
    icon: 'assets/img/clock.png',
    subtitle: 'BUY 2',
    offer: 'GET 1 FREE',
  ),
  const ClipperContainerListItem(
    title: 'FREE DISH',
    icon: 'assets/img/clock.png',
    subtitle: 'BUY 2',
    offer: 'GET 1 FREE',
  ),
];
