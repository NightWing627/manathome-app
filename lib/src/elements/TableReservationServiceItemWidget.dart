import 'package:cached_network_image/cached_network_image.dart';
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
class TableReservationServiceItemWidget extends StatefulWidget {
  TableReservationServiceItemWidget({Key key}) : super(key: key);

  @override
  _TableReservationServiceItemWidgetState createState() => _TableReservationServiceItemWidgetState();
}

class _TableReservationServiceItemWidgetState extends StateMVC<TableReservationServiceItemWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
                  ],
                ),
                child: Theme(
                  data: theme,
                  child: Column(
                      children: List.generate(
                        1,
                            (indexProduct) {
                          // ignore: non_constant_identifier_names
                          return InkWell(
                            splashColor: Theme.of(context).colorScheme.secondary,
                            focusColor: Theme.of(context).colorScheme.secondary,
                            highlightColor: Theme.of(context).primaryColor,
                            onTap: () {
                              //  product_details.value.id = orderId;
                              print('go to restaurant booking');
                              Navigator.of(context).pushNamed('/bookingServiceDetails');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Image(
                                          width: 100,
                                          height: 60,
                                          image: AssetImage('assets/img/servicedefaultbg.jpg',)
                                      )
                                  ),
                                  SizedBox(width: 15),
                                  Flexible(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Wrap(
                                                children: List.generate(1, (index) {
                                                  return Text(
                                                    'Autofficina Rossi',
                                                    style: Theme.of(context).textTheme.headline3.merge(TextStyle(fontWeight: FontWeight.w400)),
                                                  );
                                                }),
                                              ),
                                              Text(
                                                'Via Roma 41, Arona (NO)',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context).textTheme.caption,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
