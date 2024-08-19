import 'dart:collection';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:soul_sphere/domain/model/point.dart';
import 'package:soul_sphere/presentation/feature/home/widget/x_ball/xball_view.dart';

class PointAnimationSequence {
  final Point point;
  final bool needHighlight;
  final Queue<ui.Paragraph> paragraphs;

  PointAnimationSequence(this.point, this.needHighlight)
      : paragraphs = Queue<ui.Paragraph>() {
    final double fontSize = getFontSize(point.z);
    final double opacity = getFontOpacity(point.z);

    for (double fs = fontSize; fs <= 22; fs += 1) {
      paragraphs.addLast(
        buildText(point.name, 2.0 * radius, fs, opacity, needHighlight),
      );
    }

    for (double fs = 22; fs >= fontSize; fs -= 1) {
      paragraphs.addLast(
        buildText(point.name, 2.0 * radius, fs, opacity, needHighlight),
      );
    }
  }

  double getFontSize(double z) {
    return 14.0;
  }

  double getFontOpacity(double z) {
    return 1.0;
  }

  ui.Paragraph buildText(String text, double radius, double fontSize,
      double opacity, bool needHighlight) {
    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontSize: fontSize,
        textAlign: TextAlign.center,
      ),
    );
    builder.addText(text);
    return builder.build();
  }
}
