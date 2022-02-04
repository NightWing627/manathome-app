import 'package:flutter/material.dart';
import 'package:multisuperstore/src/elements/BookingItemWidget.dart';
import '../controllers/order_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../models/order_list.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../../generated/l10n.dart';

class BookingsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  BookingsWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _BookingsWidgetState createState() => _BookingsWidgetState();
}

class _BookingsWidgetState extends StateMVC<BookingsWidget> {

  _BookingsWidgetState() : super() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.grey[500],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
            'My Tables Bookings',
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
                  : 1==0
                  ? EmptyOrdersWidget()
                  : ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                reverse: true,
                primary: false,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print('$index');
                    },
                    child: BookingItemWidget()
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
