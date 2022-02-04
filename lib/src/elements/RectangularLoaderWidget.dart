import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RectangularLoaderWidget extends StatefulWidget {
  const RectangularLoaderWidget({Key key}) : super(key: key);

  @override
  _RectangularLoaderWidgetState createState() => _RectangularLoaderWidgetState();
}

class _RectangularLoaderWidgetState extends State<RectangularLoaderWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child:Column(
      children:List.generate(6, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey[300],
          period: Duration(seconds: 2),
          child:Container(
            padding: EdgeInsets.only(top: 10,left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Flexible(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Container(
                              margin: EdgeInsets.only(left:10,bottom:10,right:10),
                              height:10,width:double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left:10,bottom:10,right:10),
                              height:10,width:size.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left:10,bottom:10,right:10),
                              height:10,width:size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Wrap(children: [
                              Container(
                                margin: EdgeInsets.only(left:10,bottom:10,right:10),
                                height:10,width:size.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left:10,bottom:10,right:10),
                                height:10,width:size.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left:10,bottom:10,right:10),
                                height:10,width:size.width * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left:10,bottom:10,right:10),
                                height:10,width:size.width * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        );
      })
    ));

  }
}
