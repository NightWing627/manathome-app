import 'package:flutter/material.dart';
import 'package:multisuperstore/src/elements/EmptyTableReservationWidget.dart';
import 'package:multisuperstore/src/elements/TableReservationItemWidget.dart';
import '../controllers/order_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../models/order_list.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../../generated/l10n.dart';

class TableReservationPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  TableReservationPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _TableReservationPageState createState() => _TableReservationPageState();
}

class _TableReservationPageState extends StateMVC<TableReservationPage> {

  _TableReservationPageState() : super() {
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
            'Table Booking service',
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
                  : 1 == 0 ?
                    EmptyTableReservationWidget()
                      : ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          reverse: true,
                          primary: false,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return TableReservationItemWidget(

                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 0);
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
