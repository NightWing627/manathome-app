// ignore: must_be_immutable

import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/home_controller.dart';
import 'package:multisuperstore/src/models/explore_search.dart';
import 'package:multisuperstore/src/models/shop_type.dart';
import 'package:multisuperstore/src/pages/send_package.dart';
import 'package:multisuperstore/src/pages/stores.dart';
import 'package:multisuperstore/src/pages/subcategory.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:shimmer/shimmer.dart';

import 'CategoryshopType.dart';


class ControlPanel extends StatefulWidget {

  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends StateMVC<ControlPanel> {
  HomeController _con;
  _ControlPanelState() : super(HomeController()) {
    _con = controller;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForExplore();

  }

  @override
  Widget build(BuildContext context) {
    return Column(children:[
      Container(
          padding: EdgeInsets.only(top:20,left: 10, right: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


                  Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).your_favorites,style:Theme.of(context).textTheme.headline3),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 50,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: Colors.green,width: 1)
                            ),
                            child: Text(S.of(context).close,textAlign:TextAlign.center,style: TextStyle(color: Colors.green),),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
              Container(
                width:double.infinity,
                margin:EdgeInsets.only(left:5,right:5),
                padding: EdgeInsets.only(top:10),
                child: Wrap(
                  children: List.generate(currentRecommendation.value.length, (index) {
                    ShopType _shopTypeData = currentRecommendation.value.elementAt(index);
                    return Wrap(
                        children:[
                          Div(
                            colL:3,
                            colM:3,
                            colS:3,
                            child:Container(
                              padding: EdgeInsets.only(bottom:10),
                              child:Column(
                                  children:[
                                    GestureDetector(
                                      onTap: () {
                                        ShopType shopTypeData = ShopType();

                                        currentRecommendation.value.removeWhere((item) => item.id == _shopTypeData.id);
                                        if(currentRecommendation.value.length>=7){
                                          currentRecommendation.value.remove(7);
                                        } else {

                                          shopTypeData.id = _shopTypeData.id;
                                          shopTypeData.shopType = _shopTypeData.shopType;
                                          shopTypeData.coverImage = _shopTypeData.coverImage;
                                          shopTypeData.previewImage = _shopTypeData.previewImage;
                                          shopTypeData.title = _shopTypeData.title;
                                          shopTypeData.homeShopType = _shopTypeData.homeShopType;
                                        }


                                        currentRecommendation.value.insert(0, shopTypeData);


                                        if(_shopTypeData.shopType=='7'){
                                          currentBookDetail.value.categoryName = _shopTypeData.title;
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubCategory(id: _shopTypeData.id,)));
                                        } else if(_shopTypeData.shopType=='2'){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendPackage()));
                                        }else{
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                            return Stores(storeType: int.parse(_shopTypeData.homeShopType), pageTitle:  _shopTypeData.title,focusId: int.parse(_shopTypeData.id),
                                              coverImage: _shopTypeData.coverImage,previewImage: _shopTypeData.previewImage,);
                                          }));
                                        }

                                      },
                                      child: Container(
                                          width: 70.0,
                                          height: 70.0,
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(_shopTypeData.previewImage)
                                              )
                                          )),
                                    ),
                                    SizedBox(height:5),
                                    Container(
                                      child: Text(
                                        _shopTypeData.title,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                    ),
                                  ]
                              ),
                            ),

                          )]);


                  }),),),

                  SizedBox(
                    height: 15,
                  ),
            Text(S.of(context).other_services,style:Theme.of(context).textTheme.headline3),
            SizedBox(
              height: 10,
            ),
            _con.exploreList.isEmpty?Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey[300],
              period: Duration(seconds: 2),
              child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container(
                        width:MediaQuery.of(context).size.width*0.4,
                        height: 40,
                        padding: EdgeInsets.only(top:5,left:13,right:13,bottom:5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,

                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child:   Container(
                              child:Wrap(
                                  children:[

                                    Container(
                                        padding: EdgeInsets.only(top:3,left:10,right:5),
                                        child:Text('',
                                            textAlign: TextAlign.center,
                                            style:TextStyle(fontFamily:'Futura-Book-Regular',fontWeight: FontWeight.w100,color: Theme.of(context).hintColor)
                                        )
                                    ),

                                  ]
                              )

                          ),
                        )



                    ),
                    SizedBox(
                      height: 10,
                    ),
                Wrap(
                  children: List.generate(6, (index) {

                    return Wrap(
                        children:[
                          Div(
                            colL:3,
                            colM:3,
                            colS:3,
                            child:Container(
                              padding: EdgeInsets.only(bottom:10),
                              child:Column(
                                  children:[
                                    GestureDetector(
                                      onTap: () {



                                      },
                                      child: Container(
                                          width: 70.0,
                                          height: 70.0,
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage('assets/img/italy.png')
                                              )
                                          )),
                                    ),
                                    SizedBox(height:5),
                                    Container(
                                      child: Text(
                                        '',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                    ),
                                  ]
                              ),
                            ),

                          )]);


                  }),),

                    Container(
                        width:MediaQuery.of(context).size.width*0.4,
                        height: 40,
                        padding: EdgeInsets.only(top:5,left:13,right:13,bottom:5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,

                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child:   Container(
                              child:Wrap(
                                  children:[

                                    Container(
                                        padding: EdgeInsets.only(top:3,left:10,right:5),
                                        child:Text('',
                                            textAlign: TextAlign.center,
                                            style:TextStyle(fontFamily:'Futura-Book-Regular',fontWeight: FontWeight.w100,color: Theme.of(context).hintColor)
                                        )
                                    ),

                                  ]
                              )

                          ),
                        )



                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      children: List.generate(8, (index) {

                        return Wrap(
                            children:[
                              Div(
                                colL:3,
                                colM:3,
                                colS:3,
                                child:Container(
                                  padding: EdgeInsets.only(bottom:10),
                                  child:Column(
                                      children:[
                                        GestureDetector(
                                          onTap: () {



                                          },
                                          child: Container(
                                              width: 70.0,
                                              height: 70.0,
                                              decoration: new BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage('assets/img/italy.png')
                                                  )
                                              )),
                                        ),
                                        SizedBox(height:5),
                                        Container(
                                          child: Text(
                                            '',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context).textTheme.bodyText2,
                                          ),
                                        ),
                                      ]
                                  ),
                                ),

                              )]);


                      }),),
    ])

            ):

            ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount:  _con.exploreList.length,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(top: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                Explore _exploreData = _con.exploreList.elementAt(index);
                return Container(child:Container(
                    padding:EdgeInsets.only(left:0,right:0,top:10,bottom:10),
                   child:Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children:[
                         Container(
                           padding:EdgeInsets.only(left:10,right:10),
                           child:  Text(_exploreData.title,style:Theme.of(context).textTheme.headline4.merge(TextStyle(fontWeight: FontWeight.w800))),
                         ),

                     SizedBox(
                       height: 15,
                     ),
                    CategoryShopType(shopType: _exploreData.focusType,)
                     ])
                ),);

              }, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 5);
            },),


          ])),

    ]);
  }
}
