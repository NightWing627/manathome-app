import 'package:flutter/material.dart';
import 'package:multisuperstore/src/controllers/home_controller.dart';
import 'package:multisuperstore/src/elements/EmptyOrdersWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import '../../generated/l10n.dart';
import 'ShopListWidget.dart';
import 'custom_clipper.dart';

class SearchResultWidgetShop extends StatefulWidget {

  SearchResultWidgetShop({Key key}) : super(key: key);

  @override
  _SearchResultWidgetShopState createState() => _SearchResultWidgetShopState();
}

class _SearchResultWidgetShopState extends StateMVC<SearchResultWidgetShop> {
  HomeController _con;
  _SearchResultWidgetShopState() : super(HomeController()) {
    _con = controller;
  }

  stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();




  }

  @override
  Widget build(BuildContext context) {
    return   WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
        return false;
      },

      child: Material(
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
                        onSubmitted: (e){

                          _con.listenForVendorSearch( e);




                        },

                        autofocus: true,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).what_are_you_looking_for,
                          hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                          prefixIcon: Icon(Icons.search, color: Theme.of(context).hintColor,),
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
                    _con.loader?EmptyOrdersWidget(): Expanded(
                      child: ListView(
                        children: <Widget>[
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: _con.vendorSearch.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10);
                            },
                            itemBuilder: (context, index) {

                              return ShopList(choice: _con.vendorSearch[index], shopType:  int.parse(_con.vendorSearch[index].shopType),focusId: int.parse( _con.vendorSearch[index].focusType),previewImage:  _con.vendorSearch[index].logo);
                            },
                          ),
                          SizedBox(height: 20),

                        ],
                      ),
                    ),
                  ],
                ),
              ),)),
      ),
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
                                            print('status$val');


                                          },
                                          onError: (val) => print('onError: $val'),
                                        );
                                        if (available) {
                                          setState(() => _isListening = true);
                                          _speech.listen(
                                            onResult: (val) => setState(() {
                                              _text = val.recognizedWords;
                                              _con.listenForVendorSearch( _text);
                                              if (val.hasConfidenceRating && val.confidence > 0) {
                                                print('complete');
                                                setState(() => _isListening = false);
                                                _speech.stop();



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
