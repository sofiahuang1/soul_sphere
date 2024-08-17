import 'package:soul_sphere/app/utils/utils.dart';
import 'package:soul_sphere/presentation/feature/home/widget/number_picker_item.dart';

extension NumberPickerItemTypeExtension on int {
  NumberPickerItemType getType({
    required int minValue,
    required int maxValue,
    required int step,
  }) {
    final itemCount = Utils.calculateItemCount(
      minValue,
      maxValue,
      step,
    );

    if (this == 0) {
      return NumberPickerItemType.leftPadding;
    } else if (this == itemCount - 1) {
      return NumberPickerItemType.rightPadding;
    } else {
      return NumberPickerItemType.normal;
    }
  }
}
