import 'package:flutter/material.dart';
import 'dart:math' as math;

class TabBorderShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  final double holeSize = 70;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    print(rect.height);
    return Path.combine(
      PathOperation.difference,
      Path()..addRRect(RRect.fromRectAndCorners(rect,topLeft:Radius.circular(rect.height / 2),
          topRight:Radius.circular(rect.height / 2)))..close(),
      // Path()..addOval(
      //       Rect.fromCenter(
      //           center: rect.center.translate(0, -rect.height / 2),
      //           height: holeSize,
      //           width:100)
      //   )..close(),

      Path()..addOval(
          Rect.fromCenter(
              center: rect.center.translate(0, -rect.height / 2),
              height: holeSize,
              width:100)
      )..close(),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
  }

  @override
  ShapeBorder scale(double t) => this;
}