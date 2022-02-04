import 'dart:ui';

import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'SearchWidgetShop.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged onClickFilter;
  final Color iconColor;
  final Color labelColor;
  const SearchBarWidget(
      {Key key, this.iconColor, this.labelColor, this.onClickFilter})
      : super(key: key);
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return SearchResultWidgetShop();
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: Colors.orange[800],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 0),
                child: Icon(
                  Icons.search_outlined,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Text(
                  S.of(context).what_are_you_looking_for.toUpperCase(),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
