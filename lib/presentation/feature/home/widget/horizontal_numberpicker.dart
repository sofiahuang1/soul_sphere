import 'package:flutter/material.dart';

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
    this.scaleTransformer = _defaultScaleTransformer,
    this.scaleColor = const Color(0xFFE9E9E9),
    this.indicatorColor = const Color(0xFF3995FF),
    this.scaleTextColor = const Color(0xFF8E99A0),
  }) {
    if (subGridCountPerGrid % 2 != 0) {
      throw Exception("subGridCountPerGrid must be an even number");
    }

    if ((maxValue - minValue) % step != 0) {
      throw Exception("(maxValue - minValue) must be a multiple of step");
    }
  }

  static String _defaultScaleTransformer(int value) => value.toString();

  @override
  // ignore: library_private_types_in_public_api
  _HorizontalNumberPickerState createState() => _HorizontalNumberPickerState();
}

class _HorizontalNumberPickerState extends State<HorizontalNumberPicker> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: (widget.initialValue - widget.minValue) /
          widget.step *
          widget.subGridWidth.toDouble(),
    );
  }

  @override
  void didUpdateWidget(HorizontalNumberPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _scrollController.jumpTo((widget.initialValue - widget.minValue) /
          widget.step *
          widget.subGridWidth.toDouble());
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
          NotificationListener<ScrollNotification>(
            onNotification: _onNotification,
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _calculateItemCount(),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0 || index == _calculateItemCount() - 1) {
                  return SizedBox(
                    width: _paddingItemWidth(),
                    height: 0,
                  );
                } else {
                  return NumberPickerItem(
                    subGridCount: widget.subGridCountPerGrid,
                    subGridWidth: widget.subGridWidth,
                    itemHeight: widget.widgetHeight.toInt(),
                    valueStr: widget.scaleTransformer(_calculateValue(index)),
                    type: _getType(index),
                    scaleColor: widget.scaleColor,
                    scaleTextColor: widget.scaleTextColor,
                  );
                }
              },
            ),
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

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      int newValue = _calculateValueFromOffset(notification.metrics.pixels);
      widget.onSelectedChanged(newValue);
    }
    return true;
  }

  int _calculateItemCount() {
    return ((widget.maxValue - widget.minValue) / widget.step).ceil() + 2;
  }

  int _calculateValue(int index) {
    return widget.minValue + (index - 1) * widget.step;
  }

  double _paddingItemWidth() {
    return widget.widgetWidth * 0.1;
  }

  int _calculateValueFromOffset(double offset) {
    return widget.minValue +
        ((offset + widget.widgetWidth * 0.1) /
                widget.subGridWidth *
                widget.step)
            .toInt();
  }

  NumberPickerItemType _getType(int index) {
    if (index == 0) {
      return NumberPickerItemType.leftPadding;
    } else if (index == _calculateItemCount() - 1) {
      return NumberPickerItemType.rightPadding;
    } else {
      return NumberPickerItemType.normal;
    }
  }
}

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

class NumberPickerItemPainter extends CustomPainter {
  final int subGridCount;
  final int subGridWidth;
  final NumberPickerItemType type;
  final Color scaleColor;
  final Color scaleTextColor;
  final String valueStr;

  NumberPickerItemPainter({
    required this.subGridCount,
    required this.subGridWidth,
    required this.type,
    required this.scaleColor,
    required this.scaleTextColor,
    required this.valueStr,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = scaleColor
      ..style = PaintingStyle.stroke;

    double gridWidth = subGridWidth.toDouble();
    double startX = 0;

    for (int i = 0; i <= subGridCount; i++) {
      double x = startX + i * gridWidth;

      if (i % 10 == 0) {
        paint.strokeWidth = 2.0;
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
        _drawText(canvas, x, size.height / 2, valueStr, scaleTextColor);
      } else {
        paint.strokeWidth = 1.0;
        canvas.drawLine(Offset(x, 0), Offset(x, size.height * 0.75), paint);
      }
    }

    if (type == NumberPickerItemType.leftPadding ||
        type == NumberPickerItemType.rightPadding) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.transparent,
      );
    }
  }

  void _drawText(Canvas canvas, double x, double y, String text, Color color) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 14),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas, Offset(x - textPainter.width / 2, y - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
