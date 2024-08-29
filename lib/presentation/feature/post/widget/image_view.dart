import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.image});

  final File image;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      image,
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
