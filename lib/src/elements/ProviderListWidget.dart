import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/components/constants.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/providerlist.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import '../elements/CardsCarouselLoaderWidget.dart';


// ignore: must_be_immutable
class ProviderListWidget extends StatefulWidget {
  List<ProviderList> providerList;
  ProviderListWidget({Key key, this.providerList}) : super(key: key);

  @override
  _ProviderListWidgetState createState() => _ProviderListWidgetState();
}

class _ProviderListWidgetState extends State<ProviderListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.providerList.isEmpty
        ? CardsCarouselLoaderWidget()
        : widget.providerList[0].vendor_id == 'no_data'
            ? Positioned(
                bottom: 0.0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ], color: Colors.pink),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text(S.of(context).no_shop_found_to_near,
                        style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)))
                  ]),
                ),
              )
            : Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.providerList.length,
                  itemBuilder: (context, index) {
                    ProviderList _provider = widget.providerList.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        currentBookDetail.value.providerId = _provider.vendor_id;
                        currentBookDetail.value.providerName = _provider.name;
                        currentBookDetail.value.providerMobile = _provider.mobile;
                        currentBookDetail.value.providerImage = _provider.image;
                        Navigator.of(context).pushNamed('/H_Service', arguments: _provider);

                      },
                      child:Container(
                        margin: EdgeInsets.all(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              height:200,
                              width:150,
                              padding: EdgeInsets.only(top:0
                              ),
                              margin: EdgeInsets.only(top: Constants.avatarRadius),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ]
                              ),

                              child: Column(

                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top:29),
                                    width:60,
                                      height:25,
                                      padding: EdgeInsets.only(left:5,right:5,bottom:5,top:5),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12.withOpacity(0.1),
                                            blurRadius: 1.8,
                                            spreadRadius: 1.1,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child:  Container(
                                            child:Wrap(
                                                children:[
                                                  Icon(
                                                      Icons.star,
                                                      size:15,
                                                      color:Theme.of(context).hintColor
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(top:0),
                                                      child:Text('4.5',
                                                          textAlign: TextAlign.center,
                                                          style:TextStyle(fontFamily:'Futura-Book-Regular',fontWeight: FontWeight.w100)
                                                      )
                                                  ),

                                                ]
                                            )

                                        ),
                                      ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top:10),
                                    child:Text(_provider.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:Theme.of(context).textTheme.headline1
                                    )
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top:0,bottom:10),
                                      child:Text('1.5km',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style:Theme.of(context).textTheme.bodyText2
                                      )
                                  ),

                                  Container(
                                      padding: EdgeInsets.only(top:10,),
                                      child:Text(S.of(context).price,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style:Theme.of(context).textTheme.bodyText2
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top:0),
                                      child:Text(Helper.pricePrint(_provider.chargephrs),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style:Theme.of(context).textTheme.headline1
                                      )
                                  ),




                                ],
                              ),

                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  margin: EdgeInsets.only(top:10),
                                  alignment: Alignment.bottomRight,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:Colors.white,
                                  ),


                                  height: 69,
                                  width:69,
                                  child:ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child:Image(

                                      image: NetworkImage(
                                        _provider.image,

                                      ),
                                      height: 69,width:69,
                                      fit: BoxFit.fill,
                                    ),
                                  )


                              ),
                            ),

                          ],
                        )
                      ),
                    );
                  },
                ),
              );
  }
}
