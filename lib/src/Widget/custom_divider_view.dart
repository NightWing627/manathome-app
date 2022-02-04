import 'package:flutter/material.dart';

class CustomDividerView extends StatelessWidget {
  final double dividerHeight;
  final Color color;

  CustomDividerView({
    Key key,
    this.dividerHeight = 2.0,
    this.color,
  })  : assert(dividerHeight != 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dividerHeight,
      width: double.infinity,
      color: color == null ? Colors.orange[700] : color,
    );
  }
}
