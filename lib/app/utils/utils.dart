class Utils {
  static String defaultTitleTransformer(int value) => value.toString();
  static String defaultScaleTransformer(int value) => value.toString();

  static double calculateOffset(
    int minValue,
    int step,
    double subGridWidth,
    double widgetWidth,
    int initialValue,
  ) {
    int index = (initialValue - minValue) ~/ step;
    return index * subGridWidth - (widgetWidth * 0.5 - subGridWidth * 0.5);
  }

  static int calculateValue(
    int minValue,
    int step,
    int index,
  ) {
    return minValue + step * index;
  }

  static int calculateValueFromOffset(
    int minValue,
    double subGridWidth,
    double widgetWidth,
    double offset,
    int step,
  ) {
    int index = ((offset + widgetWidth * 0.5) / subGridWidth).floor();
    return minValue + step * index;
  }

  static int calculateItemCount(
    int minValue,
    int maxValue,
    int step,
  ) {
    return (maxValue - minValue) ~/ step + 1;
  }
}
