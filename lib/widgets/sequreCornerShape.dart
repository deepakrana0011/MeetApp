import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class SqureCornerShape extends StatelessWidget {
  Widget child;
  Color bgColor;
  Color strokeColor;
  double topLeftRadius;
  double topRightRadius;
  double bottomLeftRadius;
  double bottomRightRadius;

  SqureCornerShape(
      {required this.child,
      required this.bgColor,
      required this.topLeftRadius,
      required this.topRightRadius,
      required this.bottomLeftRadius,
      required this.bottomRightRadius,
      this.strokeColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = new ScreenScaler()..init(context);
    return Container(
        child: Material(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: strokeColor),
          borderRadius: scaler.getBorderRadiusCircularLR(topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius)),
      color: bgColor,
      child: child,
    ));
  }
}
