import 'package:flutter/material.dart';

import 'number_picker_item_painter.dart';

enum NumberPickerItemType { normal, leftPadding, rightPadding }

class NumberPickerItem extends StatelessWidget {
  final int subGridCount;
  final int subGridWidth;
  final int itemHeight;
  final String valueStr;
  final NumberPickerItemType type;
  final Color scaleColor;
  final Color scaleTextColor;

  const NumberPickerItem({
    super.key,
    required this.subGridCount,
    required this.subGridWidth,
    required this.itemHeight,
    required this.valueStr,
    required this.type,
    required this.scaleColor,
    required this.scaleTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: subGridCount * subGridWidth.toDouble(),
      height: itemHeight.toDouble(),
      child: CustomPaint(
        painter: NumberPickerItemPainter(
          subGridCount: subGridCount,
          subGridWidth: subGridWidth,
          type: type,
          scaleColor: scaleColor,
          scaleTextColor: scaleTextColor,
          valueStr: valueStr,
        ),
      ),
    );
  }
}
