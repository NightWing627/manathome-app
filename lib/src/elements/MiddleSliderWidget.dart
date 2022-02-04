import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/slide.dart';
import 'HomeSliderLoaderWidget.dart';

class MiddleSliderWidget extends StatefulWidget {
  final List<Slide> slides;

  @override
  _MiddleSliderWidgetState createState() => _MiddleSliderWidgetState();

  MiddleSliderWidget({Key key, this.slides}) : super(key: key);
}

class _MiddleSliderWidgetState extends State<MiddleSliderWidget> {


  @override
  Widget build(BuildContext context) {
    return widget.slides == null || widget.slides.isEmpty
        ? HomeSliderLoaderWidget()
        : Container(
      height: 180,
      padding: EdgeInsets.only(top:0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.slides.length,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.only(left:3,right:3),
          itemBuilder: (context, index) {
            Slide _slideData = widget.slides.elementAt(index);
            return Container(
                child: AspectRatio(
                  aspectRatio: 1.65,

                  child:  Container(
                      decoration: BoxDecoration(
                        color:Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15.0),

                      ),
                      margin: EdgeInsets.only(left:5,right:5, top: 10.0,bottom:10),
                      child: ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderRadius: BorderRadius.circular(15.0),
                          child:Material(
                            color: Colors.transparent,

                            child: InkWell(

                                splashColor:Colors.grey[100].withOpacity(0.5),
                                child:Ink.image(image:NetworkImage(_slideData.image),
                                    width:double.infinity,
                                    height:170,
                                    fit:BoxFit.fill
                                )
                            ),))
                  ),

                )

            );
          }),
    );

  }
}
