import 'dart:collection';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';

PointAnimationSequence? pointAnimationSequence;
int radius = 150;

class XBallView extends StatefulWidget {
  final MediaQueryData mediaQueryData;
  final List<String> keywords;
  final List<String> highlight;

  const XBallView({
    super.key,
    required this.mediaQueryData,
    required this.keywords,
    required this.highlight,
  });

  @override
  State<StatefulWidget> createState() {
    return _XBallViewState();
  }
}

class _XBallViewState extends State<XBallView>
    with SingleTickerProviderStateMixin {
  double sizeOfBallWithFlare = 0;
  List<Point> points = [];
  Animation<double>? animation;
  AnimationController? controller;
  double currentRadian = 0;
  Offset? lastPosition;
  Offset? downPosition;
  int lastHitTime = 0;
  Point axisVector = getAxisVector(const Offset(2, -1));

  @override
  void initState() {
    super.initState();

    sizeOfBallWithFlare = widget.mediaQueryData.size.width - 2 * 10;
    double sizeOfBall = sizeOfBallWithFlare * 32 / 35;
    radius = (sizeOfBall / 2).round();

    generatePoints(widget.keywords);

    controller = AnimationController(
        duration: const Duration(milliseconds: 40000), vsync: this);
    animation = Tween(begin: 0.0, end: pi * 2).animate(controller!)
      ..addListener(() {
        setState(() {
          for (int i = 0; i < points.length; i++) {
            rotatePoint(
                axisVector, points[i], animation!.value - currentRadian);
          }
          currentRadian = animation!.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          currentRadian = 0;
          controller!.forward(from: 0.0);
        }
      });
    controller!.forward();
  }

  @override
  void didUpdateWidget(XBallView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.keywords != widget.keywords) {
      generatePoints(widget.keywords);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void generatePoints(List<String> keywords) {
    points.clear();

    Random random = Random();

    List<double> centers = [
      0.5,
      0.35,
      0.65,
      0.35,
      0.2,
      0.5,
      0.65,
      0.35,
      0.65,
      0.8,
    ];

    double dAngleStep = 2 * pi / keywords.length;
    for (int i = 0; i < keywords.length; i++) {
      double dAngle = dAngleStep * i;
      double eAngle = (centers[i % 10] + (random.nextDouble() - 0.5) / 10) * pi;
      double x = radius * sin(eAngle) * sin(dAngle);
      double y = radius * cos(eAngle);
      double z = radius * sin(eAngle) * cos(dAngle);

      Point point = Point(x, y, z);
      point.name = keywords[i];
      bool needHight = _needHight(point.name);
      point.paragraphs = [];
      for (int z = -radius; z <= radius; z += 3) {
        point.paragraphs.add(
          buildText(
            point.name,
            2.0 * radius,
            getFontSize(z.toDouble()),
            getFontOpacity(z.toDouble()),
            needHight,
          ),
        );
      }
      points.add(point);
    }
  }

  bool _needHight(String keyword) {
    return widget.highlight.contains(keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    _buildBall(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBall() {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        int now = DateTime.now().millisecondsSinceEpoch;
        downPosition = convertCoordinate(event.localPosition);
        lastPosition = convertCoordinate(event.localPosition);
        clearQueue();
        addToQueue(PositionWithTime(downPosition!, now));
        controller?.stop();
      },
      onPointerMove: (PointerMoveEvent event) {
        int now = DateTime.now().millisecondsSinceEpoch;
        Offset currentPostion = convertCoordinate(event.localPosition);

        addToQueue(PositionWithTime(currentPostion, now));

        Offset delta = Offset(currentPostion.dx - lastPosition!.dx,
            currentPostion.dy - lastPosition!.dy);
        double distance = sqrt(delta.dx * delta.dx + delta.dy * delta.dy);
        if (distance > 2) {
          setState(() {
            lastPosition = currentPostion;
            double radian = distance / radius;
            axisVector = getAxisVector(delta);
            for (int i = 0; i < points.length; i++) {
              rotatePoint(axisVector, points[i], radian);
            }
          });
        }
      },
      onPointerUp: (PointerUpEvent event) {
        int now = DateTime.now().millisecondsSinceEpoch;
        Offset upPosition = convertCoordinate(event.localPosition);

        addToQueue(PositionWithTime(upPosition, now));

        Offset velocity = getVelocity();
        if (sqrt(velocity.dx * velocity.dx + velocity.dy * velocity.dy) >= 1) {
          currentRadian = 0;
          controller!.fling();
        } else {
          currentRadian = 0;
          controller!.forward(from: 0.0);
        }

        double distanceSinceDown = sqrt(
            pow(upPosition.dx - downPosition!.dx, 2) +
                pow(upPosition.dy - downPosition!.dy, 2));
        if (distanceSinceDown < 4) {
          int searchRadiusW = 30;
          int searchRadiusH = 10;
          for (int i = 0; i < points.length; i++) {
            if (points[i].z >= 0 &&
                (upPosition.dx - points[i].x).abs() < searchRadiusW &&
                (upPosition.dy - points[i].y).abs() < searchRadiusH) {
              int now = DateTime.now().millisecondsSinceEpoch;
              if (now - lastHitTime > 2000) {
                lastHitTime = now;

                pointAnimationSequence = PointAnimationSequence(
                    points[i], _needHight(points[i].name));

                Future.delayed(const Duration(milliseconds: 500), () {
                  debugPrint("click${points[i].name}”");
                });
              }
              break;
            }
          }
        }
      },
      onPointerCancel: (_) {
        currentRadian = 0;
        controller!.forward(from: 0.0);
      },
      child: ClipOval(
        child: CustomPaint(
          size: Size(2.0 * radius, 2.0 * radius),
          painter: MyPainter(points),
        ),
      ),
    );
  }

  void clearQueue() {}

  void addToQueue(PositionWithTime positionWithTime) {}

  Offset getVelocity() {
    return Offset.zero;
  }
}

class MyPainter extends CustomPainter {
  final List<Point> points;
  late Paint ballPaint;
  late Paint pointPaint;

  MyPainter(this.points) {
    ballPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length; i++) {
      List<double> xy = transformCoordinate(points[i]);

      ui.Paragraph p;
      if (pointAnimationSequence?.point == points[i]) {
        if (pointAnimationSequence!.paragraphs.isNotEmpty) {
          p = pointAnimationSequence!.paragraphs.removeFirst();
        } else {
          p = points[i].getParagraph(radius);
          pointAnimationSequence = null;
        }
      } else {
        p = points[i].getParagraph(radius);
      }

      double halfWidth = p.minIntrinsicWidth / 2;
      double halfHeight = p.height / 2;
      canvas.drawParagraph(
        p,
        Offset(xy[0] - halfWidth, xy[1] - halfHeight),
      );
    }
  }

  List<double> transformCoordinate(Point point) {
    return [radius + point.x, radius - point.y, point.z];
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

void rotatePoint(
  Point axis,
  Point point,
  double radian,
) {
  double x = cos(radian) * point.x +
      (1 - cos(radian)) *
          (axis.x * point.x + axis.y * point.y + axis.z * point.z) *
          axis.x +
      sin(radian) * (axis.y * point.z - axis.z * point.y);

  double y = cos(radian) * point.y +
      (1 - cos(radian)) *
          (axis.x * point.x + axis.y * point.y + axis.z * point.z) *
          axis.y +
      sin(radian) * (axis.z * point.x - axis.x * point.z);

  double z = cos(radian) * point.z +
      (1 - cos(radian)) *
          (axis.x * point.x + axis.y * point.y + axis.z * point.z) *
          axis.z +
      sin(radian) * (axis.x * point.y - axis.y * point.x);

  point.x = x;
  point.y = y;
  point.z = z;
}

double getRadian(double distance) {
  return distance / radius;
}

Offset convertCoordinate(Offset offset) {
  return Offset(offset.dx - radius, radius - offset.dy);
}

Point getAxisVector(Offset scrollVector) {
  double x = -scrollVector.dy;
  double y = scrollVector.dx;
  double module = sqrt(x * x + y * y);
  return Point(x / module, y / module, 0);
}

ui.Paragraph buildText(
  String content,
  double maxWidth,
  double fontSize,
  double opacity,
  bool highLight,
) {
  String text = content;
  if (content.length > 5) {
    String firstLine = text.substring(0, 5);
    String secondLine = text.substring(5);
    if (secondLine.length > 5) {
      secondLine = "${secondLine.substring(0, 4)}...";
    }
    text = "$firstLine\n$secondLine";
  }

  ui.ParagraphBuilder paragraphBuilder =
      ui.ParagraphBuilder(ui.ParagraphStyle());
  paragraphBuilder.pushStyle(
    ui.TextStyle(
        fontSize: fontSize,
        color: highLight ? Colors.white.withOpacity(opacity) : AppColors.purple,
        height: 1.0,
        shadows: highLight
            ? [
                Shadow(
                  color: Colors.white.withOpacity(opacity),
                  offset: const Offset(0, 0),
                  blurRadius: 10,
                )
              ]
            : []),
  );
  paragraphBuilder.addText(text);

  ui.Paragraph paragraph = paragraphBuilder.build();
  paragraph.layout(ui.ParagraphConstraints(width: maxWidth));
  return paragraph;
}

double getFontSize(double z) {
  return 8 + 8 * (z + radius) / (2 * radius);
}

double getFontOpacity(double z) {
  return 0.5 + 0.5 * (z + radius) / (2 * radius);
}

class Point {
  double x, y, z;
  late String name;
  late List<ui.Paragraph> paragraphs;

  Point(this.x, this.y, this.z);

  ui.Paragraph getParagraph(int radius) {
    int index = (z + radius).round() ~/ 3;
    return paragraphs[index];
  }
}

class PositionWithTime {
  Offset position;
  int time;

  PositionWithTime(this.position, this.time);
}

class PointAnimationSequence {
  final Point point;
  final bool needHighlight;
  final Queue<ui.Paragraph> paragraphs;

  PointAnimationSequence(this.point, this.needHighlight)
      : paragraphs = Queue<ui.Paragraph>() {
    final double fontSize = getFontSize(point.z);
    final double opacity = getFontOpacity(point.z);

    for (double fs = fontSize; fs <= 22; fs += 1) {
      paragraphs.addLast(
        buildText(point.name, 2.0 * radius, fs, opacity, needHighlight),
      );
    }

    for (double fs = 22; fs >= fontSize; fs -= 1) {
      paragraphs.addLast(
        buildText(point.name, 2.0 * radius, fs, opacity, needHighlight),
      );
    }
  }

  double getFontSize(double z) {
    return 14.0;
  }

  double getFontOpacity(double z) {
    return 1.0;
  }

  ui.Paragraph buildText(String text, double radius, double fontSize,
      double opacity, bool needHighlight) {
    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontSize: fontSize,
        textAlign: TextAlign.center,
      ),
    );
    builder.addText(text);
    return builder.build();
  }
}
