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
class OrderItemWidget extends StatefulWidget {
  final bool expanded;
  OrderList orderdetails;
  OrderItemWidget({Key key, this.expanded, this.orderdetails}) : super(key: key);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends StateMVC<OrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    final f = DateFormat('yyyy-MM-dd hh:mm');
    int timeInMillis = int.parse(widget.orderdetails.sale_datetime);
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
                        Text('${S.of(context).order_id}: #${widget.orderdetails.sale_code}',style:TextStyle(color:Theme.of(context).primaryColorDark)),
                        Text(
                          f.format(DateTime.fromMillisecondsSinceEpoch(timeInMillis * 1000)),
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
                        Text('${Helper.pricePrint(widget.orderdetails.grand_total)}', style: Theme.of(context).textTheme.headline3),
                        Text(
                          '${widget.orderdetails.payment_type}',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    children: <Widget>[
                      Column(
                          children: List.generate(
                        widget.orderdetails.product_details.length,
                        (indexProduct) {
                          // ignore: non_constant_identifier_names
                          CartResponce ProductDetails = widget.orderdetails.product_details.elementAt(indexProduct);
                          return ProductOrderItemWidget(
                            product_detailData: ProductDetails,
                            orderId: widget.orderdetails.sale_code,
                            shopTypeId:  widget.orderdetails.shopTypeId,
                          );
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
