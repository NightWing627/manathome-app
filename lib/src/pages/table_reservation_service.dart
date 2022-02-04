import 'package:flutter/material.dart';
import 'package:multisuperstore/src/elements/EmptyTableReservationWidget.dart';
import 'package:multisuperstore/src/elements/TableReservationItemWidget.dart';
import 'package:multisuperstore/src/elements/TableReservationServiceItemWidget.dart';
import '../controllers/order_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../models/order_list.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../../generated/l10n.dart';

class TableReservationServicePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  TableReservationServicePage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _TableReservationServicePageState createState() => _TableReservationServicePageState();
}

class _TableReservationServicePageState extends StateMVC<TableReservationServicePage> {

  _TableReservationServicePageState() : super() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
            'Meccanico',
            style: Theme.of(context).textTheme.headline3
        ),
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
                  return TableReservationServiceItemWidget(

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
