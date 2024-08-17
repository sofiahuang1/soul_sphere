import 'package:flutter/material.dart';
import 'package:soul_sphere/app/utils/utils.dart';
import 'package:soul_sphere/presentation/feature/home/widget/custom_picker_stack.dart';
import 'package:soul_sphere/presentation/feature/home/widget/wrapper_row.dart';

class HorizontalNumberPickerWrapper extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;
  final String unit;
  final double widgetWidth;
  final int subGridCountPerGrid;
  final int subGridWidth;
  final void Function(int) onSelectedChanged;
  final String Function(int) titleTransformer;
  final String Function(int) scaleTransformer;
  final Color titleTextColor;
  final Color scaleColor;
  final Color indicatorColor;
  final Color scaleTextColor;

  const HorizontalNumberPickerWrapper({
    super.key,
    this.initialValue = 500,
    this.minValue = 100,
    this.maxValue = 900,
    this.step = 1,
    this.unit = "",
    this.widgetWidth = 200.0,
    this.subGridCountPerGrid = 10,
    this.subGridWidth = 8,
    required this.onSelectedChanged,
    this.titleTransformer = Utils.defaultTitleTransformer,
    this.scaleTransformer = Utils.defaultScaleTransformer,
    this.titleTextColor = const Color(0xFF3995FF),
    this.scaleColor = const Color(0xFFE9E9E9),
    this.indicatorColor = const Color(0xFF3995FF),
    this.scaleTextColor = const Color(0xFF8E99A0),
  });

  @override
  HorizontalNumberPickerWrapperState createState() =>
      HorizontalNumberPickerWrapperState();
}

class HorizontalNumberPickerWrapperState
    extends State<HorizontalNumberPickerWrapper> {
  int _selectedValue = 500;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(HorizontalNumberPickerWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _selectedValue = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double numberPickerHeight = 60.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        WrapperRow(widget: widget, selectedValue: _selectedValue),
        const SizedBox(height: 10),
        CustomPickerStack(
          initialValue: widget.initialValue,
          minValue: widget.minValue,
          maxValue: widget.maxValue,
          step: widget.step,
          widgetWidth: widget.widgetWidth,
          widgetHeight: numberPickerHeight,
          subGridCountPerGrid: widget.subGridCountPerGrid,
          subGridWidth: widget.subGridWidth,
          onSelectedChanged: (value) {
            widget.onSelectedChanged(value);
            setState(() {
              _selectedValue = value;
            });
          },
          scaleTransformer: widget.scaleTransformer,
          scaleColor: widget.scaleColor,
          indicatorColor: widget.indicatorColor,
          scaleTextColor: widget.scaleTextColor,
        ),
      ],
    );
  }
}
