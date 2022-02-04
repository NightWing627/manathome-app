

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../Widget/creditCard.dart';

class CardsList extends StatefulWidget {
  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends StateMVC<CardsList> {






  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, left: 15.0, right: 15.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Cards', style: Theme.of(context).textTheme.headline3),

              ],
            ),
          ),
         /** _con.walletList == null || _con.walletList.isEmpty
              ? HomeSliderLoaderWidget()
              :Container(
            height: 246.0,
            child: PageView.builder(
              itemCount: _con.walletList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Wallet _walletData = _con.walletList.elementAt(index);
                return  CreditCard(card: _walletData);
              },
            ),
          ), */
         Container(
         height: 246.0,
         child: PageView.builder(
    itemCount: 1,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {

    return  CreditCard();
    },
    )),

        ],
      ),
    );
  }
}


