

import 'package:flutter/material.dart';
import '../pages/wallet_transcation.dart';


class TransactionCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final String price;
  final String letter;
  final Color color;
  final String transactionId;
  final String date;
  TransactionCard({
    this.color,
    this.letter,
    this.price,
    this.subTitle,
    this.title,
    this.transactionId,
    this.date
  });
  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionPage(
                color: widget.color,
                title: widget.title,
                subTitle: widget.subTitle,
                price: widget.price,
                letter: widget.letter,
                  transactionId: widget.transactionId,
                date: widget.date,
              ),
            ),
          );
        },
        child: Container(
          height: 62.0,
          width: 343.0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 44.0,
                        width: 44.0,
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: Center(
                          child: Text(
                            widget.letter,
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.title,style: Theme.of(context).textTheme.bodyText1
                              ),
                          Text(widget.subTitle,
                              style: TextStyle(color:Theme.of(context).disabledColor.withOpacity(0.9),fontWeight: FontWeight.w500)
                              ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(widget.price,
                          style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: widget.letter=='C'?Colors.green:Colors.red,fontWeight: FontWeight.w400))
                      ),
                      SizedBox(width: 4.0),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  )
                ],
              ),
              Divider(
                color: Colors.grey.withOpacity(0.5),
                thickness: 0.5,
                endIndent: 16.0,
                indent: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
