import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/utils/utils.dart';
import 'package:soul_sphere/presentation/feature/home/widget/horizontal_number_picker_state.dart';

class HorizontalNumberPicker extends StatefulWidget {
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

  HorizontalNumberPicker({
    super.key,
    this.initialValue = 500,
    this.minValue = 100,
    this.maxValue = 900,
    this.step = 1,
    this.widgetWidth = 200.0,
    this.widgetHeight = 60.0,
    this.subGridCountPerGrid = 10,
    this.subGridWidth = 8,
    required this.onSelectedChanged,
    this.scaleTransformer = Utils.defaultScaleTransformer,
    this.scaleColor = AppColors.scaleColor,
    this.indicatorColor = AppColors.indicatorColor,
    this.scaleTextColor = AppColors.scaleTextColor,
  }) {
    if (subGridCountPerGrid % 2 != 0) {
      throw Exception("subGridCountPerGrid must be an even number");
    }

    if ((maxValue - minValue) % step != 0) {
      throw Exception("(maxValue - minValue) must be a multiple of step");
    }
  }

  @override
  HorizontalNumberPickerState createState() => HorizontalNumberPickerState();
}
