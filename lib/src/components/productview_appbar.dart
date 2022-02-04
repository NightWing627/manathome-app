import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../elements/ShoppingCartButtonWidget.dart';


class ProDetaiAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child:Align(

        alignment: Alignment.topCenter,
        child:InkWell(
          onTap: () {

          },

          child:   Padding(
            padding: EdgeInsets.only(top: 27.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  color:Theme.of(context).primaryColor,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child:
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 19,
                    ),
                      color: Theme.of(context).hintColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child:Text('Product List',
                    textAlign:TextAlign.center,
                    style:Theme.of(context)
                        .textTheme
                        .headline4

                  ),
                ),

                SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                Wrap(

                  children: [

                    SizedBox(width:10),
                    ShoppingCartButtonWidget(
                        iconColor: Theme.of(context).hintColor,
                        labelColor: Theme.of(context).colorScheme.secondary),
                  ],
                )
              ],
            ),
          ),

        )
    ),
    );
  }
}