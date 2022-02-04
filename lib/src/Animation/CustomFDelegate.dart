import 'package:flutter/material.dart';

class CustomFDelegate extends FlowDelegate {
  CustomFDelegate({this.myAnimation}) : super(repaint: myAnimation);

  final Animation<double> myAnimation;

  @override
  void paintChildren(FlowPaintingContext context) async {
    context.paintChild(0, transform: Matrix4.translationValues(0, 0, 0));

    context.paintChild(1,
        transform: Matrix4.translationValues(
            -100 * this.myAnimation.value, 70 * this.myAnimation.value, 0));
    context.paintChild(2,
        transform: Matrix4.translationValues(
            -100 * this.myAnimation.value, -40 * this.myAnimation.value, 0));
    context.paintChild(3,
        transform:
            Matrix4.translationValues(0, -110 * this.myAnimation.value, 0));
    context.paintChild(4,
        transform: Matrix4.translationValues(
            100 * this.myAnimation.value, -40 * this.myAnimation.value, 0));
    context.paintChild(5,
        transform: Matrix4.translationValues(
            100 * this.myAnimation.value, 70 * this.myAnimation.value, 0));
    context.paintChild(6,
        transform:
            Matrix4.translationValues(0, 110 * this.myAnimation.value, 0));
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    throw UnimplementedError();
  }

  // Put overridden methods here
}
