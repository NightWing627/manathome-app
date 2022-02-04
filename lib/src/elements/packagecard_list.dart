
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/slide.dart';


class PackageCardList extends StatefulWidget {
  final Slide slides;
  PackageCardList({Key key, this.slides}) : super(key: key);
  @override
  _PackageCardListState createState() => _PackageCardListState();
}

class _PackageCardListState extends State<PackageCardList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20.0, left: 20, top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.pink[50],
        border: Border.all(color: Colors.brown[200], width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:Image(image: NetworkImage(widget.slides.image),
        width:double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
