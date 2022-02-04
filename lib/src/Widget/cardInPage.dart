
import 'package:flutter/material.dart';

class CardInPage extends StatefulWidget {
  final String title;
  final String subTitle;
  final String price;
  final String letter;
  final Color color;
  CardInPage({
    this.color,
    this.letter,
    this.price,
    this.subTitle,
    this.title,
  });
  @override
  _CardInPageState createState() => _CardInPageState();
}

class _CardInPageState extends State<CardInPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        height: 57.0,
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
                        Text(widget.title,
                            style: Theme.of(context).textTheme.bodyText1
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
                        style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.red,fontWeight: FontWeight.w400))
                    ),
                    SizedBox(width: 4.0),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
