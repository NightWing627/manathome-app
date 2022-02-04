import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/elements/AddCartSliderWidget.dart';

class SearchItem extends StatefulWidget {
  const SearchItem({Key key}) : super(key: key);

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: 6,
            scrollDirection: Axis.vertical,
            primary: false,
            itemBuilder: (context, index) {
              return Column(
                  children:[
                    Container(
                        padding: EdgeInsets.only(left:20,right:20),
                        child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Container(
                                child:Image(image:AssetImage('assets/img/flutterwave.png',),
                                  height: 40,width:40,
                                ),
                              ),
                              Expanded(
                                  child:Container(
                                      padding: EdgeInsets.only(left:10,),
                                      child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[
                                            Container(
                                                child:Text('Kovai palmudi milayam',
                                                  style:Theme.of(context).textTheme.subtitle1,
                                                )
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(top:5,),
                                                child:Wrap(
                                                    children:[
                                                      Icon(Icons.access_time,size:15),
                                                      SizedBox(width:3),
                                                      Text('22 mins',style:Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                                                          color:Theme.of(context).disabledColor.withOpacity(0.8)
                                                      ))),
                                                      SizedBox(width:6),
                                                      Icon(Icons.circle,color:Colors.green,size:15),
                                                      SizedBox(width:3),
                                                      Text('Free Delivery')
                                                    ]
                                                )
                                            )
                                          ]
                                      )
                                  )
                              ),
                              Align(
                                  child:Container(
                                      padding: EdgeInsets.only(left:10),
                                      child:IconButton(
                                          onPressed: (){},
                                          icon:Icon(Icons.arrow_forward_outlined)
                                      )
                                  )
                              )
                            ]
                        )
                    ),

                    SizedBox(height:5),

                    AddCartSliderWidget(),
                  ]
              );

            }
        ),
      ],
    ));
  }
}
