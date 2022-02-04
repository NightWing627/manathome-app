//import 'package:banking_app/utilities/themeColors.dart';
//import 'package:banking_app/utilities/themeStyles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multisuperstore/generated/l10n.dart';
import '../Widget/cardInPage.dart';
import '../Widget/otherDetailsDivider.dart';

class TransactionPage extends StatefulWidget {
  final String title;
  final String subTitle;
  final String price;
  final String letter;
  final Color color;
  final String transactionId;
  final String date;
  TransactionPage({
    this.color,
    this.letter,
    this.price,
    this.subTitle,
    this.title,
    this.transactionId,
    this.date
  });
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details', style:Theme.of(context).textTheme.headline3),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 32.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Text(S.of(context).transaction,style: Theme.of(context).textTheme.headline3
                          ),
                    ],
                  ),
                ),
                CardInPage(
                  color: widget.color,
                  title: widget.title,
                  subTitle: widget.subTitle,
                  price: widget.price,
                  letter: widget.letter,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 32.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Text(S.of(context).details,style: Theme.of(context).textTheme.headline3 ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 5.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: SvgPicture.asset('assets/icons/bankTransfer-icon.svg'),
                      ),
                      Text('Bank Transfer',
                          style: Theme.of(context).textTheme.bodyText1
                          ),
                    ],
                  ),
                ),
                OtherDetailsDivider(),

                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).status, style: TextStyle(color:Theme.of(context).disabledColor,fontWeight: FontWeight.w500)),
                      SizedBox(height: 5.0),
                      widget.title=='debit'?Text('Your amount is debited',
                          style: Theme.of(context).textTheme.bodyText1
                          ):Text('Your amount is credited',
                          style: Theme.of(context).textTheme.bodyText1
                      ),
                    ],
                  ),
                ),
                OtherDetailsDivider(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Transaction ID',
                          style: TextStyle(color:Theme.of(context).disabledColor,fontWeight: FontWeight.w500)
                      ),
                      SizedBox(height: 5.0),
                      Text(widget.transactionId,
                          style: Theme.of(context).textTheme.bodyText1
                          ),
                    ],
                  ),
                ),
                OtherDetailsDivider(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).date,
                          style: TextStyle(color:Theme.of(context).disabledColor,fontWeight: FontWeight.w500)
                      ),
                      SizedBox(height: 5.0),
                      Text(widget.date,
                          style: Theme.of(context).textTheme.bodyText1
                      ),
                    ],
                  ),
                ),
                OtherDetailsDivider(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).status,
                          style: TextStyle(color:Theme.of(context).disabledColor,fontWeight: FontWeight.w500)
                          ),
                      SizedBox(height: 5.0),
                      Text('Success',
                          style: Theme.of(context).textTheme.bodyText1
                      ),
                    ],
                  ),
                ),
                OtherDetailsDivider(),



              ],
            ),

          ],
        ),
      ),
    );
  }
}


class ThemeColors {
  static Color lightGrey = Color(0xffE8E8E9);
  static Color black = Color(0xff14121E);
  static Color grey = Color(0xFF8492A2);
}