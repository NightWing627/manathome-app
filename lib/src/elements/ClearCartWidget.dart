import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class ClearCart extends StatefulWidget {
  @override
  _ClearCartState createState() => _ClearCartState();
}

class _ClearCartState extends StateMVC<ClearCart> {


  bool loader = false;



  int selectedRadio;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Stack(
      children:[
        Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(top:10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.add_shopping_cart,color:Colors.blue,size: 30,),

                                SizedBox(width:20),
                                IconButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    icon:Icon(Icons.close)
                                )


                              ],
                            ),
                            InkWell(
                              onTap: () {},
                              child:Text(S.of(context).clear_cart,style:Theme.of(context).textTheme.headline1),
                            ),


                            SizedBox(height: 5,),
                            Text(S.of(context).your_cart_contains_items_from_all_new_shop_do_you_want_to_clear_the_cart_and_raise_the_new_order,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),




                          ]
                      )
                  ),
                ),
              ])
        ),

      ]
    );
  }
}