import 'dart:ui' as ui;

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
