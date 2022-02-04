import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/cart_responce.dart';
import '../controllers/order_controller.dart';
import '../models/subscription_checkout.dart';
import 'orderItemProductWidget.dart';

class MyscheduleItemWidget extends StatefulWidget {
  final bool expanded;
  final SubscriptionCheckout subscription;
  final OrderController con;
  MyscheduleItemWidget({
    Key key,
    this.expanded,
    this.subscription,
    this.con
  }) : super(key: key);

  @override
  _MyscheduleItemWidgetState createState() => _MyscheduleItemWidgetState();
}

class _MyscheduleItemWidgetState extends State<MyscheduleItemWidget> {
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
                margin: EdgeInsets.only(top: 14),
                padding: EdgeInsets.only(top: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
                  ],
                ),
                child: Theme(
                  data: theme,
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: Column(
                      children: <Widget>[
                       Wrap(
                          children: [
                            Text(S.of(context).subscription),
                            SizedBox(width:2),
                            Text(widget.subscription.frequency, style: Theme.of(context).textTheme.subtitle1,)
                          ],
                        ),

                        Text(
                          '#${widget.subscription.saleCode}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(Helper.pricePrint(widget.subscription.grand_total), style: Theme.of(context).textTheme.headline4),
                        /*Text(
                          'Cash',
                          style: Theme.of(context).textTheme.caption,
                        )*/
                      ],
                    ),
                    children: <Widget>[
                      Column(
                          children: List.generate(
                            widget.subscription.cart.length,
                        (indexProduct) {
                          CartResponce productDetails =  widget.subscription.cart.elementAt(indexProduct);
                          return OrderItemProductWidget(productDetails: productDetails);
                        },
                      )),


                    ],
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
