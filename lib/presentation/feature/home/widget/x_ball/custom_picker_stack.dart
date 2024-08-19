import 'package:flutter/material.dart';

import 'horizontal_numberpicker.dart';

class CustomPickerStack extends StatelessWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;
  final double widgetWidth;
  final double widgetHeight;
  final int subGridCountPerGrid;
  final int subGridWidth;
  final void Function(int) onSelectedChanged;
  final String Function(int) scaleTransformer;
  final Color scaleColor;
  final Color indicatorColor;
  final Color scaleTextColor;

  const CustomPickerStack({
    super.key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.step,
    required this.widgetWidth,
    required this.widgetHeight,
    required this.subGridCountPerGrid,
    required this.subGridWidth,
    required this.onSelectedChanged,
    required this.scaleTransformer,
    required this.scaleColor,
    required this.indicatorColor,
    required this.scaleTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        HorizontalNumberPicker(
          initialValue: initialValue,
          minValue: minValue,
          maxValue: maxValue,
          step: step,
          widgetWidth: widgetWidth,
          widgetHeight: widgetHeight,
          subGridCountPerGrid: subGridCountPerGrid,
          subGridWidth: subGridWidth,
          onSelectedChanged: onSelectedChanged,
          scaleTransformer: scaleTransformer,
          scaleColor: scaleColor,
          indicatorColor: indicatorColor,
          scaleTextColor: scaleTextColor,
        ),
        Positioned(
          left: 0,
          child: Container(
            width: 20,
            height: widgetHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 20,
            height: widgetHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0.8),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
