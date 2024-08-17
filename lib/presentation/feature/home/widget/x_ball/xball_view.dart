import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/domain/model/point.dart';
import 'package:soul_sphere/domain/model/position_with_time.dart';
import 'package:soul_sphere/presentation/feature/home/widget/x_ball/my_painter.dart';
import 'package:soul_sphere/presentation/feature/home/widget/x_ball/point_animation_sequence.dart';
import 'package:soul_sphere/presentation/feature/home/widget/x_ball/rotate_point.dart';

import '../../../../../app/utils/point_utils.dart';
import '../../../../../app/utils/utils.dart';

PointAnimationSequence? pointAnimationSequence;
int radius = 150;

class XBallView extends StatefulWidget {
  final MediaQueryData mediaQueryData;
  final List<String> keywords;
  final List<String> highlight;
  final String userId;

  const XBallView({
    super.key,
    required this.mediaQueryData,
    required this.keywords,
    required this.highlight,
    required this.userId,
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
  Point axisVector = Utils.getAxisVector(const Offset(2, -1));

  @override
  void initState() {
    super.initState();

    sizeOfBallWithFlare = widget.mediaQueryData.size.width - 2 * 10;
    double sizeOfBall = sizeOfBallWithFlare * 32 / 35;
    radius = (sizeOfBall / 2).round();

    generatePoints(widget.keywords, radius, points);

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
      generatePoints(widget.keywords, radius, points);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  bool _needHight(String keyword) {
    return widget.highlight.contains(keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: 400,
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
        downPosition = Utils.convertCoordinate(event.localPosition);
        lastPosition = Utils.convertCoordinate(event.localPosition);
        clearQueue();
        addToQueue(PositionWithTime(downPosition!, now));
        controller?.stop();
      },
      onPointerMove: (PointerMoveEvent event) {
        int now = DateTime.now().millisecondsSinceEpoch;
        Offset currentPostion = Utils.convertCoordinate(event.localPosition);

        addToQueue(PositionWithTime(currentPostion, now));

        Offset delta = Offset(currentPostion.dx - lastPosition!.dx,
            currentPostion.dy - lastPosition!.dy);
        double distance = sqrt(delta.dx * delta.dx + delta.dy * delta.dy);
        if (distance > 2) {
          setState(() {
            lastPosition = currentPostion;
            double radian = distance / radius;
            axisVector = Utils.getAxisVector(delta);
            for (int i = 0; i < points.length; i++) {
              rotatePoint(axisVector, points[i], radian);
            }
          });
        }
      },
      onPointerUp: (PointerUpEvent event) {
        int now = DateTime.now().millisecondsSinceEpoch;
        Offset upPosition = Utils.convertCoordinate(event.localPosition);

        addToQueue(PositionWithTime(upPosition, now));

        Offset velocity = Utils.getVelocity();
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
                  context.push(
                    '${AppPaths.userDetailPagePath}/${widget.userId}',
                  );
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
}
