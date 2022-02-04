
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/slide.dart';
import 'packagecard_list.dart';


class PackageCard extends StatefulWidget {
  final List<Slide> slides;
  PackageCard({Key key, this.slides}) : super(key: key);
  @override
  _PackageCardState createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {




  final PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      //_currentCard = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          Container(
            height: 150,
            child: PageView.builder(
              itemCount: widget.slides.length,
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) => PackageCardList(slides: widget.slides.elementAt(index),),
            ),
          ),

        ],
      ),
    );
  }
}


