import 'package:flutter/material.dart';
import 'package:soul_sphere/app/utils/utils.dart';

class ScrollNotificationHandler {
  static bool handleScrollNotification(
    ScrollNotification notification,
    Function(int) onSelectedChanged,
    int minValue,
    double subGridWidth,
    double widgetWidth,
    int step,
  ) {
    if (notification is ScrollEndNotification) {
      int newValue = Utils.calculateValueFromOffset(
        minValue,
        subGridWidth,
        widgetWidth,
        notification.metrics.pixels,
        step,
      );
      onSelectedChanged(newValue);
    }
    return true;
  }
}
