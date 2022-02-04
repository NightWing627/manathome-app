import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/trending.dart';

class TreandingweeWidget extends StatefulWidget {
  final List<Trending> trending;
  TreandingweeWidget({Key key, this.trending}) : super(key: key);
  @override
  _TreandingweeWidgetState createState() => _TreandingweeWidgetState();
}

class _TreandingweeWidgetState extends State<TreandingweeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:205,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.trending.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(right:20,bottom:10,top:10),
          itemBuilder: (context, index) {
            return Trendingslider(choice: widget.trending[index]);
          }),
    );
  }
}

class Trendingslider extends StatelessWidget {
  const Trendingslider({Key key, this.choice}) : super(key: key);
  final Trending choice;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 1)],
        ),
        padding: EdgeInsets.only(left: 20,),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
          child: Image.network(
            choice.image,
            width: MediaQuery.of(context).size.width * 0.8,
            height: 200,
            fit: BoxFit.fill,
          ),
        ));
  }
}
