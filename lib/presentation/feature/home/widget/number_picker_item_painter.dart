import 'package:flutter/material.dart';
import 'package:soul_sphere/presentation/feature/home/widget/number_picker_item.dart';

class NumberPickerItemPainter extends CustomPainter {
  final int subGridCount;
  final int subGridWidth;
  final NumberPickerItemType type;
  final Color scaleColor;
  final Color scaleTextColor;
  final String valueStr;

  NumberPickerItemPainter({
    required this.subGridCount,
    required this.subGridWidth,
    required this.type,
    required this.scaleColor,
    required this.scaleTextColor,
    required this.valueStr,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = scaleColor
      ..style = PaintingStyle.stroke;

    double gridWidth = subGridWidth.toDouble();
    double startX = 0;

    for (int i = 0; i <= subGridCount; i++) {
      double x = startX + i * gridWidth;

      if (i % 10 == 0) {
        paint.strokeWidth = 2.0;
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
        _drawText(canvas, x, size.height / 2, valueStr, scaleTextColor);
      } else {
        paint.strokeWidth = 1.0;
        canvas.drawLine(Offset(x, 0), Offset(x, size.height * 0.75), paint);
      }
    }

    if (type == NumberPickerItemType.leftPadding ||
        type == NumberPickerItemType.rightPadding) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.transparent,
      );
    }
  }

  void _drawText(Canvas canvas, double x, double y, String text, Color color) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 14),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
