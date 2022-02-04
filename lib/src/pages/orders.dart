import 'package:flutter/material.dart';
import '../controllers/order_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../models/order_list.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../../generated/l10n.dart';

class OrdersWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  OrdersWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends StateMVC<OrdersWidget> {
  OrderController _con;

  _OrdersWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).my_orders,
          style: Theme.of(context).textTheme.headline3
        ),
        actions: <Widget>[
          ShoppingCartButtonWidget(iconColor: Theme.of(context).backgroundColor.withOpacity(0.5), labelColor:Theme.of(context).primaryColorLight),
        ],
      ),
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : RefreshIndicator(
              onRefresh: _refreshLocalGallery,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    currentUser.value.apiToken == null
                        ? PermissionDeniedWidget()
                        : _con.orders.isEmpty
                            ? EmptyOrdersWidget()
                            : ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                reverse: true,
                                primary: false,
                                itemCount: _con.orders.length,
                                itemBuilder: (context, index) {
                                  OrderList _orderlist = _con.orders.elementAt(index);

                                  return OrderItemWidget(
                                    orderdetails: _orderlist,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 20);
                                },
                              ),
                  ],
                ),
              ),
            ),
    );
  }
}

Future<Null> _refreshLocalGallery() async {
  print('refreshing stocks...');
}
