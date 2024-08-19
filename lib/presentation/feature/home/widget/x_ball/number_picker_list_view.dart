import 'package:flutter/material.dart';
import 'package:soul_sphere/app/extension/number_picker_extensions.dart';
import 'package:soul_sphere/app/utils/utils.dart';

import 'number_picker_item.dart';
import 'scroll_notification_handler.dart';

class NumberPickerListView extends StatelessWidget {
  final ScrollController scrollController;
  final int minValue;
  final int maxValue;
  final int step;
  final double widgetWidth;
  final int subGridCountPerGrid;
  final int subGridWidth;
  final String Function(int) scaleTransformer;
  final Color scaleColor;
  final Color scaleTextColor;
  final void Function(int) onSelectedChanged;

  const NumberPickerListView({
    super.key,
    required this.scrollController,
    required this.minValue,
    required this.maxValue,
    required this.step,
    required this.widgetWidth,
    required this.subGridCountPerGrid,
    required this.subGridWidth,
    required this.scaleTransformer,
    required this.scaleColor,
    required this.scaleTextColor,
    required this.onSelectedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) =>
          ScrollNotificationHandler.handleScrollNotification(
        notification,
        onSelectedChanged,
        minValue,
        subGridWidth.toDouble(),
        widgetWidth,
        step,
      ),
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: Utils.calculateItemCount(
          minValue,
          maxValue,
          step,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0 ||
              index ==
                  Utils.calculateItemCount(
                        minValue,
                        maxValue,
                        step,
                      ) -
                      1) {
            return SizedBox(
              width: widgetWidth * 0.1,
              height: 0,
            );
          } else {
            return NumberPickerItem(
              subGridCount: subGridCountPerGrid,
              subGridWidth: subGridWidth,
              itemHeight: widgetWidth.toInt(),
              valueStr: scaleTransformer(Utils.calculateValue(
                minValue,
                step,
                index,
              )),
              type: index.getType(
                minValue: minValue,
                maxValue: maxValue,
                step: step,
              ),
              scaleColor: scaleColor,
              scaleTextColor: scaleTextColor,
            );
          }
        },
      ),
    );
  }
}
