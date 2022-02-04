import 'package:flutter/material.dart';
import '../Widget/custom_divider_view.dart';

class CouponScreen extends StatefulWidget {
  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("swiggy"),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20.0),
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3.8,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              padding: EdgeInsets.only(right: 20),
              itemBuilder: (context, index) => Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: MultipleRoundedCurveClipper(),
                    child: Container(
                      padding: EdgeInsets.only(left: 20.0, right: 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3.8,
                        width: MediaQuery.of(context).size.width / 2.6,
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent.withOpacity(0.3),
                            /*border: Border.all(
                        color:Colors.grey[300],
                        width:1
                      ),*/
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
                              color: Colors.blue,
                              /*gradient: new LinearGradient(
                              colors: [
                                Colors.red.withOpacity(0.6),
                                Colors.yellow.withOpacity(0.6),
                              ]
                          ),*/
                            ),
                            width: 50.0,
                            height: 50.0,
                            child: Image(
                              image: AssetImage('assets/img/clock.png'),
                              height: 20,
                              width: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('free_dish', style: (TextStyle(color: Colors.blue))),
                          Text('buy_2', style: Theme.of(context).textTheme.headline1.merge(TextStyle(color: Colors.blue))),
                          Text('get_1_free', style: Theme.of(context).textTheme.headline1.merge(TextStyle(color: Colors.blue)))
                        ])),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          CustomDividerView(dividerHeight: 15.0),
          Container(
            height: MediaQuery.of(context).size.height / 8,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0, right: 10),
                          child: Container(
                            width: 45,
                            height: 45,
                            child: new CircleAvatar(
                              backgroundImage: new AssetImage("assets/img/food2.jpg"),
                              radius: 80.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                              child: Text('Order delivered from recently barbequeen restaurant',
                                  overflow: TextOverflow.ellipsis, maxLines: 2, style: Theme.of(context).textTheme.subtitle2)),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey[300], size: 20),
                        SizedBox(width: 5),
                        Container(
                          height: MediaQuery.of(context).size.height / 12,
                          padding: EdgeInsets.only(top: 30, bottom: 30),
                          decoration: BoxDecoration(border: Border(right: BorderSide(width: 1, color: Colors.grey[200]))),
                        ),
                      ],
                    )),
              ),
            ),
          ),
          CustomDividerView(dividerHeight: 15.0),
        ],
      ),
    );
  }
}

class MultipleRoundedCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 10;
    while (curXPos < size.width) {
      curXPos += increment;
      path.arcToPoint(Offset(curXPos, curYPos), radius: Radius.circular(10));
    }
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
