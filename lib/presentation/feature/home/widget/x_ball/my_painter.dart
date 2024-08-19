import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:soul_sphere/app/utils/utils.dart';
import 'package:soul_sphere/domain/model/point.dart';
import 'package:soul_sphere/presentation/feature/home/widget/x_ball/xball_view.dart';

class MyPainter extends CustomPainter {
  final List<Point> points;
  late Paint ballPaint;
  late Paint pointPaint;

  MyPainter(this.points) {
    ballPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length; i++) {
      List<double> xy = Utils.transformCoordinate(points[i]);

      ui.Paragraph p;
      if (pointAnimationSequence?.point == points[i]) {
        if (pointAnimationSequence!.paragraphs.isNotEmpty) {
          p = pointAnimationSequence!.paragraphs.removeFirst();
        } else {
          p = points[i].getParagraph(radius);
          pointAnimationSequence = null;
        }
      } else {
        p = points[i].getParagraph(radius);
      }

      double halfWidth = p.minIntrinsicWidth / 2;
      double halfHeight = p.height / 2;
      canvas.drawParagraph(
        p,
        Offset(xy[0] - halfWidth, xy[1] - halfHeight),
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
