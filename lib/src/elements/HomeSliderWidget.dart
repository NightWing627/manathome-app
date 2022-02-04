import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/helper.dart';
import '../models/slide.dart';
import 'HomeSliderLoaderWidget.dart';

class HomeSliderWidget extends StatefulWidget {
  final List<Slide> slides;

  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();

  HomeSliderWidget({Key key, this.slides}) : super(key: key);
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;
  AlignmentDirectional _alignmentDirectional;

  @override
  Widget build(BuildContext context) {
    return widget.slides == null || widget.slides.isEmpty
        ? HomeSliderLoaderWidget()
        : widget.slides == null || widget.slides.isEmpty
        ? HomeSliderLoaderWidget()
        : Stack(
      alignment: _alignmentDirectional ?? Helper.getAlignmentDirectional('bottom_start'),
      fit: StackFit.passthrough,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            height: 180,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
                _alignmentDirectional = Helper.getAlignmentDirectional('bottom_start');
              });
            },
          ),
          items: widget.slides.map((Slide slide) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  height: 180,
                 
                  child: InkWell(
                    onTap: (){

                     /** if(slide.superCategoryId!='2' && slide.superCategoryId!='7') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  StoresGeneral(superId: slide.superCategoryId, pageTitle: slide.slider_text,
                              coverImage: slide.image, offer: slide.para, offerType: slide.redirect_type,)));


                      }  else if(slide.superCategoryId=='7'){
                       /** currentBookDetail.value.categoryName = slide.slider_text;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubCategory(id: _shopTypeData.id,))); */
                      } else if(slide.superCategoryId=='2'){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendPackage()));
                      } */
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            slide.image,
                            fit: BoxFit.fill,
                            height: 180,
                            width: double.infinity,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                        /**  Container(
                            alignment: Helper.getAlignmentDirectional('bottom_start'),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                            width: config.App(context).appWidth(40),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            if (slide.slider_text != null && slide.slider_text != '')
                            Text(
                            slide.slider_text,
                            style: Theme.of(context).textTheme.headline6.merge(
                            TextStyle(
                            fontSize: 14,
                            height: 1,
                            color: Helper.of(context).getColorFromHex('#25d366'),
                            ),
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                            ),
                            if (slide.button_text != null && slide.button_text != '')
                            FlatButton(
                            onPressed: () {
                            // if (slide.market != null) {
                            // Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: slide.market.id, heroTag: 'home_slide'));
                            // } else if (slide.product != null) {
                            // Navigator.of(context).pushNamed('/Product', arguments: RouteArgument(id: slide.product.id, heroTag: 'home_slide'));
                            // }
                            },
                            padding: EdgeInsets.symmetric(vertical: 5),
                            color: Theme.of(context).splashColor,
                            shape: StadiumBorder(),
                            child: Text(
                            slide.button_text,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Theme.of(context).primaryColor),
                            ),
                            ),
                            ],
                            ),
                            ),
                            ), */
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 22, horizontal: 42),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.slides.map((Slide slide) {
              return Container(
                width: 20.0,
                height: 3.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: _current == widget.slides.indexOf(slide)
                        ? Helper.of(context).getColorFromHex('#25d366')
                        : Helper.of(context).getColorFromHex('#25d366').withOpacity(0.3)),
              );
            }).toList(),
          ),
        ),
      ],
    );

  }
}
