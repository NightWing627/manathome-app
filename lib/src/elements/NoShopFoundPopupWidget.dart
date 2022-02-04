import 'package:flutter/material.dart';

class NoShopFoundPopupWidget extends StatefulWidget {
  NoShopFoundPopupWidget({
    Key key,
  }) : super(key: key);

  @override
  _NoShopFoundPopupWidgetState createState() => _NoShopFoundPopupWidgetState();
}

class _NoShopFoundPopupWidgetState extends State<NoShopFoundPopupWidget> {
  bool loading = true;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          /*Container(
            width:size.width * 0.1,
          ),*/
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width:size.width * 0.4,
                child:Image(
                  image: AssetImage(
                    'assets/img/noshopfound.png',
                  ),
                  height: 200,
                  width:size.width * 0.4,
                ),
              ),

            ],
          ),

         /* Container(
            width:size.width * 0.1,
          ),*/

        ]
      )
    );



  }
}
