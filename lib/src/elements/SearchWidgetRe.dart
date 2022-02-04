import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/product_details2.dart';
import 'package:multisuperstore/src/models/restaurant_product.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/product_controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import '../../generated/l10n.dart';
import 'RestaurantProductBox.dart';
import 'custom_clipper.dart';

// ignore: must_be_immutable
class SearchResultWidgetRe extends StatefulWidget {
  final  List<RestaurantProduct> itemDetails;
  String shopId;
  String shopName;
  String subtitle;
  String km;
  int shopTypeID;
  String latitude;
  String longitude;
  Function callback;
  int focusId;

  SearchResultWidgetRe({Key key, this.itemDetails,this.shopId, this.shopName, this.subtitle, this.km, this.shopTypeID, this.latitude, this.longitude, this.callback, this.focusId}) : super(key: key);

  @override
  _SearchResultWidgetReState createState() => _SearchResultWidgetReState();
}

class _SearchResultWidgetReState extends StateMVC<SearchResultWidgetRe> {
  ProductController _con;
  List<ProductDetails2> itemList = <ProductDetails2>[];
  _SearchResultWidgetReState() : super(ProductController()) {
    _con = controller;
  }

  stt.SpeechToText _speech;
  bool _isListening = false;
  List<ProductDetails2> productList = <ProductDetails2>[];
  List<ProductDetails2> tempList = <ProductDetails2>[];
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();



    widget.itemDetails.forEach((element) {
      productList.addAll(element.productdetails);
    });
    itemList = productList;
    tempList = productList;
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
          minimum: EdgeInsets.only(top: 40),
          child: SafeArea(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(

                      onChanged: (e) {


                        setState((){
                          // itemList = _con.rTypeProductSearch(itemList, e);

                          itemList  = tempList
                              .where((u) =>
                          (u.product_name.toLowerCase().contains(e.toLowerCase())) ||
                              (u.id.toLowerCase().contains(e.toLowerCase())))
                              .toList();
                        });

                      },
                      autofocus: true,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: S.of(context).what_are_you_looking_for,
                        hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                        prefixIcon: Icon(Icons.search, color: Theme.of(context).hintColor),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.mic),
                          color: Theme.of(context).hintColor,
                          onPressed: () {
                            _isListening = false;
                            ShowClipper();
                          },
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: itemList.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemBuilder: (context, index) {
                            ProductDetails2 _suggestion = itemList.elementAt(index);
                            return RestaurantProductBox(choice: _suggestion, con: _con,shopId: widget.shopId,shopName: widget.shopName,subtitle: widget.subtitle,km: widget.km, shopTypeID: widget.shopTypeID,longitude: widget.longitude,latitude: widget.latitude,callback: widget.callback,focusId: widget.focusId,);
                          },
                        ),
                        SizedBox(height: 20),

                      ],
                    ),
                  ),
                ],
              ),
            ),)),
    );
  }

  // ignore: non_constant_identifier_names
  void ShowClipper() {
    String _text = S.of(context).press_the_button_and_start_speaking;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              color: Color(0xff737373),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  Expanded(
                    child: ClipPath(
                      clipper: CustomShape(), // this is my own class which extendsCustomClipper
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                    SizedBox(height: 10),
                                    Text(
                                      _text,
                                      style: Theme.of(context).textTheme.headline3.merge(TextStyle(fontWeight: FontWeight.w400)),
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 5),
                                child: AvatarGlow(
                                  animate: _isListening,
                                  glowColor: Colors.green,
                                  endRadius: 75.0,
                                  duration: const Duration(milliseconds: 2000),
                                  repeatPauseDuration: const Duration(milliseconds: 100),
                                  repeat: true,
                                  child: FloatingActionButton(
                                    onPressed: () async {
                                      if (!_isListening) {
                                        bool available = await _speech.initialize(
                                          onStatus: (val) {

                                          },
                                          onError: (val) => print('onError: $val'),
                                        );
                                        if (available) {
                                          setState(() => _isListening = true);
                                          _speech.listen(
                                            onResult: (val) => setState(() {
                                              _text = val.recognizedWords;

                                              if (val.hasConfidenceRating && val.confidence > 0) {
                                                print('complete');
                                                setState(() => _isListening = false);
                                                _speech.stop();

                                                setState((){
                                                  // itemList = _con.rTypeProductSearch(itemList, e);

                                                  itemList  = tempList
                                                      .where((u) =>
                                                  (u.product_name.toLowerCase().contains(_text.toLowerCase())) ||
                                                      (u.id.toLowerCase().contains(_text.toLowerCase())))
                                                      .toList();
                                                });

                                                Navigator.pop(context);
                                              }

                                            }),
                                          );
                                        }
                                      } else {
                                        setState(() => _isListening = false);
                                        _speech.stop();
                                      }
                                    },
                                    child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
