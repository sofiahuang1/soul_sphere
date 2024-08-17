import 'package:flutter/material.dart';
import 'package:soul_sphere/app/utils/utils.dart';
import 'package:soul_sphere/presentation/feature/home/widget/x_ball/horizontal_numberpicker.dart';

import 'number_picker_list_view.dart';

class HorizontalNumberPickerState extends State<HorizontalNumberPicker> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: Utils.calculateOffset(
        widget.minValue,
        widget.step,
        widget.subGridWidth.toDouble(),
        widget.widgetWidth,
        widget.initialValue,
      ),
    );
  }

  @override
  void didUpdateWidget(HorizontalNumberPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _scrollController.jumpTo(Utils.calculateOffset(
        widget.minValue,
        widget.step,
        widget.subGridWidth.toDouble(),
        widget.widgetWidth,
        widget.initialValue,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.widgetWidth,
      height: widget.widgetHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          NumberPickerListView(
            scrollController: _scrollController,
            minValue: widget.minValue,
            maxValue: widget.maxValue,
            step: widget.step,
            widgetWidth: widget.widgetWidth,
            subGridCountPerGrid: widget.subGridCountPerGrid,
            subGridWidth: widget.subGridWidth,
            scaleTransformer: widget.scaleTransformer,
            scaleColor: widget.scaleColor,
            scaleTextColor: widget.scaleTextColor,
            onSelectedChanged: widget.onSelectedChanged,
          ),
          Container(
            width: widget.widgetWidth,
            height: widget.widgetHeight,
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: widget.widgetWidth * 0.1,
                height: 2.0,
                color: widget.indicatorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
