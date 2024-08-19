import 'package:flutter/material.dart';
import 'package:soul_sphere/presentation/feature/home/widget/x_ball/horizontal_numberpicker_wrapper.dart';

class WrapperRow extends StatelessWidget {
  const WrapperRow({
    super.key,
    required this.widget,
    required int selectedValue,
  }) : _selectedValue = selectedValue;

  final HorizontalNumberPickerWrapper widget;
  final int _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Text(
          widget.titleTransformer(_selectedValue),
          style: TextStyle(
            color: widget.titleTextColor,
            fontSize: 40,
          ),
        ),
        Text(
          ' ${widget.unit}',
          style: TextStyle(
            color: widget.titleTextColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
