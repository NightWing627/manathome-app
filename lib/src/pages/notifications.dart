import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../elements/DrawerWidget.dart';
import '../../generated/l10n.dart';
import '../repository/user_repository.dart';
import '../elements/PermissionDeniedWidget.dart';

class NotificationsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  NotificationsWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends StateMVC<NotificationsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).notifications,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {},
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: <Widget>[
                Icon(
                  Icons.notifications_none,
                  color: Theme.of(context).hintColor,
                  size: 28,
                ),
                Container(
                  child: Text(
                    '1',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption.merge(
                          TextStyle(color: Theme.of(context).primaryColor, fontSize: 8),
                        ),
                  ),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(minWidth: 13, maxWidth: 13, minHeight: 13, maxHeight: 13),
                ),
              ],
            ),
            color: Colors.transparent,
          )
        ],
      ),
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
         :Container()
    );
  }
}
