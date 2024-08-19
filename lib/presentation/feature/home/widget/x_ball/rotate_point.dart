import 'dart:math';

import 'package:soul_sphere/domain/model/point.dart';

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
