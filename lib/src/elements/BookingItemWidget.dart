import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/cart_responce.dart';
import '../models/order_list.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'ProductOrderItemWidget.dart';
import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import 'package:intl/intl.dart' show DateFormat;

// ignore: must_be_immutable
class BookingItemWidget extends StatefulWidget {
  final bool expanded;
  BookingItemWidget({Key key, this.expanded}) : super(key: key);

  @override
  _BookingItemWidgetState createState() => _BookingItemWidgetState();
}

class _BookingItemWidgetState extends StateMVC<BookingItemWidget> {
  @override
  Widget build(BuildContext context) {
    final f = DateFormat('yyyy-MM-dd hh:mm');
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
                  ],
                ),
                child: GestureDetector(
                    onTap: () {
                      print('0');
                    },
                    child: ExpansionTile(
                      initiallyExpanded: true,

                      title: Column(
                        children: <Widget>[
                          Text('Booking ID: #',style:TextStyle(color:Theme.of(context).primaryColorDark)),
                          Text(
                            'Date : 2021.11.24',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            'Time : 20:00',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Restaurant name : Red Beef', style: TextStyle(color:Theme.of(context).primaryColorDark)),
                          Text(
                            'Number of Guests : 5',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            'Status : Pending',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Booking ID : 1234567890"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
