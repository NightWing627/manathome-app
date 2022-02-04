import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/ShoppingCartButtonWidget.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  void showModal;
  CustomAppBar({
    this.parentScaffoldKey,
    this.showModal,
    Key key,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Wrap(children: [
        Container(
          padding: EdgeInsets.only(left: 5, top: 5),
          child: InkWell(
            onTap: () => widget.parentScaffoldKey.currentState.openDrawer(),
            child: Icon(Icons.menu, size: 40, color: Colors.orange),
          ),
        ),
      ]),
      actions: <Widget>[
        loader
            ? SizedBox(
                width: 60,
                height: 60,
                child: RefreshProgressIndicator(),
              )
            : ShoppingCartButtonWidget(
                iconColor: Theme.of(context).backgroundColor.withOpacity(0.5),
                labelColor: Theme.of(context).splashColor),
      ],
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      title: GestureDetector(
          onTap: () => widget.showModal,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            currentUser.value.latitude == null ||
                    currentUser.value.longitude == null
                ? Text(S.of(context).select_your_address,
                    style: Theme.of(context).textTheme.bodyText2.merge(
                        TextStyle(
                            fontFamily: 'Futura-Book-Bold',
                            fontWeight: FontWeight.w800,
                            fontSize: 13)))
                : Text(currentUser.value.selected_address,
                    style: Theme.of(context).textTheme.bodyText2.merge(
                        TextStyle(
                            fontFamily: 'Futura-Book-Bold',
                            fontWeight: FontWeight.w800,
                            fontSize: 13))),
          ])),
    );
  }
}
