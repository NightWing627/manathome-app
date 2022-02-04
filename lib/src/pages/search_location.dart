import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/repository/settings_repository.dart';


// ignore: must_be_immutable
class SearchLocation extends StatefulWidget {

  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {



  Future<void> handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
 await PlacesAutocomplete.show(
      context: context,
      apiKey: setting.value.googleMapsKey,
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),



    );


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title:Container(
              width: double.infinity,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          'Set delivery location',
                          style: Theme.of(context).textTheme.subtitle2,
                          textAlign: TextAlign.left,
                        ),

                      ]),
                    ),

                  ],
                ),
              InkWell(
                onTap: (){
                  handlePressButton();
                },
                child: Text(
                    '11.1/46, chinnapampaty main road, malayampalayam',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.left,
                  ),
              )
              ])
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 15, top:20,bottom: 15),
                                  child:Container(
                                    decoration: BoxDecoration(

                                    ),
                                    width: double.infinity,
                                    padding: EdgeInsets.only(bottom: 0),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(

                                            child: Padding(
                                              padding:EdgeInsets.only(top:6),
                                              child: Icon(Icons.my_location, color: Colors.orange),
                                            ),
                                          ),

                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                              Text('Current Location', style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Colors.orange))),
                                              Text('Using Gps',
                                                style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Colors.orange)),
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ]),
                                          ),
                                        ]),
                                  ),
                                ),

                                Container(
                                  width:double.infinity,
                                  decoration: BoxDecoration(
                                      color:Theme.of(context).dividerColor
                                  ),
                                  padding: EdgeInsets.all(5),

                                ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Container(
                                  padding: EdgeInsets.only(top:20,bottom:15),
                                  child:Text('SAVED ADDRESSES',
                                      style:TextStyle(color:Colors.orange)
                                  ),
                                ),
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: EdgeInsets.only(top: 10),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      return Column(children: [

                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                  color: Theme.of(context).dividerColor,
                                                  width: 1,
                                                )),
                                          ),
                                          width: double.infinity,
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:EdgeInsets.only(top:6),
                                                  child: Icon(Icons.home_outlined, color: Theme.of(context).disabledColor),
                                                ),

                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                    Text(S.of(context).home, style: Theme.of(context).textTheme.bodyText1),
                                                    Text('11.1/46, chinnapampaty main road, malayampalayam',
                                                      style: Theme.of(context).textTheme.caption,
                                                      textAlign: TextAlign.left,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ]),
                                                ),
                                              ]),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(top:10,bottom:10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                  color: Theme.of(context).dividerColor,
                                                  width: 1,
                                                )),
                                          ),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Padding(
                                              padding:EdgeInsets.only(top:6),
                                              child: Icon(Icons.location_on_outlined, color: Theme.of(context).disabledColor),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                Text('Company', style: Theme.of(context).textTheme.bodyText1),
                                                Text(
                                                    '11.1/46, chinnapampaty main road, malayampalayam',
                                                  style: Theme.of(context).textTheme.caption,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ]),
                                            ),
                                          ]),
                                        ),
                                      ]);
                                    }),

                              SizedBox(height:10),
                                // ignore: deprecated_member_use
                                FlatButton(
                                    color: Colors.transparent,
                                    hoverColor: Theme.of(context).primaryColor,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                    },
                                    child: Container(
                                      child: Text(S.of(context).view_more,
                                          style:TextStyle(color:Colors.orange)
                                      ),
                                    )
                                ),



                              ]),
                            ),







                          ]),
                        ]),
                  ),
                ),
              ),

            ],
          ),
        )
    );




  }
}















