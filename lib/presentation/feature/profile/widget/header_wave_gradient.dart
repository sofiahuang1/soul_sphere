import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';

class HeaderWaveGradient extends StatelessWidget {
  const HeaderWaveGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderWavePainter(),
      ),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = AppColors.primaryGradient
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(0, size.height * 0.7)
      ..cubicTo(size.width * 0.25, size.height * 0.5, size.width * 0.3,
          size.height * 0.9, size.width * 0.5, size.height * 0.7)
      ..cubicTo(size.width * 0.7, size.height * 0.45, size.width * 0.8,
          size.height * 0.95, size.width, size.height * 0.65)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
