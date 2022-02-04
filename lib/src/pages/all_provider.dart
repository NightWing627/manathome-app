
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/Animation/FadeAnimation.dart';
import 'package:multisuperstore/src/models/providerlist.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';


// ignore: must_be_immutable
class AllProvider extends StatefulWidget{
  List<ProviderList> providerList;
  AllProvider({Key key, this.providerList}) : super(key: key);
  @override
  _AllProviderState createState() => _AllProviderState();
}

class _AllProviderState extends State<AllProvider> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
           color: Theme.of(context).primaryColorDark),
        child: SafeArea(child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only( left: 10.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color:Theme.of(context).primaryColorLight.withOpacity(0.8),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10.0),
                  Text(S.of(context).all_provider,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Theme.of(context).primaryColorLight.withOpacity(0.8))),
                  ),
                ],
              ),
            ),


            SizedBox(height: 20),
            Expanded(
              child: Container(
                width:double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(

                  child: Column(
                    children: <Widget>[
/* 1st image start */
                    Container(
                      padding: EdgeInsets.only(
                        left: 20.0, right: 20.0,  top: 40.0),
                      child:Wrap(
                        children: List.generate(widget.providerList.length, (index) {
                          ProviderList _provider = widget.providerList.elementAt(index);
                          return Div(
                            colS:12,
                            colM:6,
                            colL:4,
                            child:FadeAnimation(

                              1.4,

                              Container(
                                margin: EdgeInsets.all(10),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(20.0),

                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child:new Container(
                                        margin:EdgeInsets.only(right:40,top:40),
                                        height:105,width:105,

                                        child: Card(
                                          child: new CircleAvatar(
                                            backgroundImage: new NetworkImage(_provider.image),
                                            radius: 80.0,
                                          ),
                                          elevation: 2.0,
                                          shape: CircleBorder(),
                                          clipBehavior: Clip.antiAlias,
                                        ),

                                      ),
                                    ),
                                    /*Container(
                                alignment: Alignment.bottomRight,
                                padding:EdgeInsets.only(top:10.0,bottom:1.0),

                                child: Image(
                                  image: AssetImage(
                                    "assets/img/docter.png",
                                  ),
                                  height: 200,
                                  width: 160,
                                ),
                              ),*/
                                    SizedBox(width:10.0),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0, right:20,top: 30.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.55,
                                            child:  Text(_provider.name,

                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3

                                              ),
                                            ),


                                          SizedBox(
                                            height: 10.0,
                                          ),

                                          Text(currentBookDetail.value.subcategoryName,

                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.star_half,
                                                color: Theme.of(context).colorScheme.secondary,
                                              ),
                                              SizedBox(width: 5.0),
                                              Text( _provider.rating.toString(),

                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height:25.0),
                                          // ignore: deprecated_member_use
                                          FlatButton(
                                            onPressed: () {
                                              currentBookDetail.value.providerId = _provider.vendor_id;
                                              currentBookDetail.value.providerName = _provider.name;
                                              currentBookDetail.value.providerMobile = _provider.mobile;
                                              currentBookDetail.value.providerImage = _provider.image;
                                              Navigator.of(context).pushNamed('/H_Service', arguments: _provider);

                                            },
                                            padding: EdgeInsets.symmetric(vertical: size.width > 769 ? 13 :10, horizontal: 30),
                                            color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                            shape: StadiumBorder(),
                                            child: Text(S.of(context).view_profile,
                                              style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ),
                          );
                        }),
                      ),
                    ),



/* 1st image end */

                      SizedBox(height:30.0),




                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        )
      ),
    );
  }
}