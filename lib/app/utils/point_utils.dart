import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/domain/model/point.dart';

import '../../../../../app/utils/utils.dart';

void generatePoints(List<String> keywords, int radius, List<Point> points) {
  points.clear();

  Random random = Random();

  double dAngleStep = 2 * pi / keywords.length;
  for (int i = 0; i < keywords.length; i++) {
    double dAngle = dAngleStep * i;
    double eAngle =
        (AppConstants.centers[i % 10] + (random.nextDouble() - 0.5) / 10) * pi;
    double x = radius * sin(eAngle) * sin(dAngle);
    double y = radius * cos(eAngle);
    double z = radius * sin(eAngle) * cos(dAngle);

    Point point = Point(x, y, z);
    point.name = keywords[i];
    bool needHighlight = _needHighlight(point.name);
    point.paragraphs = [];
    for (int z = -radius; z <= radius; z += 3) {
      point.paragraphs.add(
        buildText(
          point.name,
          2.0 * radius,
          Utils.getFontSize(z.toDouble()),
          Utils.getFontOpacity(z.toDouble()),
          needHighlight,
        ),
      );
    }
    points.add(point);
  }
}

bool _needHighlight(String keyword) {
  return false;
}

ui.Paragraph buildText(
  String content,
  double maxWidth,
  double fontSize,
  double opacity,
  bool highLight,
) {
  String text = content;
  if (content.length > 5) {
    String firstLine = text.substring(0, 5);
    String secondLine = text.substring(5);
    if (secondLine.length > 5) {
      secondLine = "${secondLine.substring(0, 4)}...";
    }
    text = "$firstLine\n$secondLine";
  }

  ui.ParagraphBuilder paragraphBuilder =
      ui.ParagraphBuilder(ui.ParagraphStyle());
  paragraphBuilder.pushStyle(
    ui.TextStyle(
        fontSize: fontSize,
        color: highLight ? Colors.white.withOpacity(opacity) : AppColors.purple,
        height: 1.0,
        shadows: highLight
            ? [
                Shadow(
                  color: Colors.white.withOpacity(opacity),
                  offset: const Offset(0, 0),
                  blurRadius: 10,
                )
              ]
            : []),
  );
  paragraphBuilder.addText(text);

  ui.Paragraph paragraph = paragraphBuilder.build();
  paragraph.layout(ui.ParagraphConstraints(width: maxWidth));
  return paragraph;
}
