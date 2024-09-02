import 'package:flutter/material.dart';
import 'package:soul_sphere/presentation/feature/onboarding/widget/slide_main_column.dart';

class Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;
  final double titleSize;
  final double captionSize;

  const Slide({
    super.key,
    required this.title,
    required this.caption,
    required this.imageUrl,
    this.titleSize = 24.0,
    this.captionSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: SildeMainColumn(
            imageUrl: imageUrl,
            title: title,
            titleSize: titleSize,
            caption: caption,
            captionSize: captionSize),
      ),
    );
  }
}
