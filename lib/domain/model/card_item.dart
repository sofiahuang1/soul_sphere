import 'package:flutter/material.dart';

class CardItem {
  final String imageUrl;
  final String text;
  final String route;
  final Color color;

  CardItem(this.imageUrl, this.text, this.route, Color? color)
      : color = color ?? Colors.grey;
}
