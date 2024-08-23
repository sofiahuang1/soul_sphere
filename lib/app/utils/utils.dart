import 'dart:math';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:soul_sphere/domain/model/point.dart';

class Utils {
  static String defaultTitleTransformer(int value) => value.toString();
  static String defaultScaleTransformer(int value) => value.toString();

  static double calculateOffset(
    int minValue,
    int step,
    double subGridWidth,
    double widgetWidth,
    int initialValue,
  ) {
    int index = (initialValue - minValue) ~/ step;
    return index * subGridWidth - (widgetWidth * 0.5 - subGridWidth * 0.5);
  }

  static int calculateValue(
    int minValue,
    int step,
    int index,
  ) {
    return minValue + step * index;
  }

  static int calculateValueFromOffset(
    int minValue,
    double subGridWidth,
    double widgetWidth,
    double offset,
    int step,
  ) {
    int index = ((offset + widgetWidth * 0.5) / subGridWidth).floor();
    return minValue + step * index;
  }

  static int calculateItemCount(
    int minValue,
    int maxValue,
    int step,
  ) {
    return (maxValue - minValue) ~/ step + 1;
  }

  static int radius = 150;

  static double getRadian(double distance) {
    return distance / radius;
  }

  static Offset convertCoordinate(Offset offset) {
    return Offset(offset.dx - radius, radius - offset.dy);
  }

  static Offset getVelocity() {
    return Offset.zero;
  }

  static List<double> transformCoordinate(Point point) {
    return [radius + point.x, radius - point.y, point.z];
  }

  static double getFontSize(double z) {
    return 8 + 8 * (z + radius) / (2 * radius);
  }

  static double getFontOpacity(double z) {
    return 0.5 + 0.5 * (z + radius) / (2 * radius);
  }

  static Point getAxisVector(Offset scrollVector) {
    double x = -scrollVector.dy;
    double y = scrollVector.dx;
    double module = sqrt(x * x + y * y);
    return Point(x / module, y / module, 0);
  }

  static String generateChatId(String userId1, String userId2) {
    return userId1.hashCode <= userId2.hashCode
        ? '${userId1}_$userId2'
        : '${userId2}_$userId1';
  }

  static String formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      return DateFormat.jm().format(timestamp);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat.E().format(timestamp);
    } else {
      return DateFormat.yMMMd().format(timestamp);
    }
  }
}
