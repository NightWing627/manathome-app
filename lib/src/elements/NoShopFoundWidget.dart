import 'package:flutter/material.dart';

class NoShopFoundWidget extends StatefulWidget {
  NoShopFoundWidget({
    Key key,
  }) : super(key: key);

  @override
  _NoShopFoundWidgetState createState() => _NoShopFoundWidgetState();
}

class _NoShopFoundWidgetState extends State<NoShopFoundWidget> {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Container(
            width:size.width * 0.3,
          ),
          Column(
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

          Container(
            width:size.width * 0.3,
          ),

        ]
      )
    );



  }
}
