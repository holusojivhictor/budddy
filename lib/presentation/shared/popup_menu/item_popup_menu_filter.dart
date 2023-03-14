import 'package:buddy/colors.dart';
import 'package:buddy/presentation/shared/utils/enum_utils.dart';
import 'package:flutter/material.dart';

typedef PopupMenuItemText<T> = String Function(T value, int index);

class ItemPopupMenuFilter<TEnum> extends StatelessWidget {
  final String toolTipText;
  final TEnum selectedValue;
  final Function(TEnum)? onSelected;
  final List<TEnum> values;
  final List<TEnum> exclude;
  final Icon icon;
  final PopupMenuItemText<TEnum> itemText;

  const ItemPopupMenuFilter({
    Key? key,
    required this.toolTipText,
    required this.selectedValue,
    required this.values,
    this.onSelected,
    required this.itemText,
    this.exclude = const [],
    this.icon = const Icon(Icons.keyboard_arrow_right, color: Color(0xFF8B8C8C), size: 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TEnum>(
      padding: EdgeInsets.zero,
      surfaceTintColor: AppColors.tertiary,
      initialValue: selectedValue,
      icon: icon,
      onSelected: handleItemSelected,
      itemBuilder: (context) {
        final translatedValues = getTranslatedValues(context);
        return getValuesToUse(context, translatedValues);
      },
      tooltip: toolTipText,
    );
  }

  List<TranslatedEnum<TEnum>> getTranslatedValues(BuildContext context) {
    return EnumUtils.getTranslatedAndSortedEnum<TEnum>(values, itemText, exclude: exclude);
  }

  List<CheckedPopupMenuItem<TEnum>> getValuesToUse(BuildContext context, List<TranslatedEnum<TEnum>> translatedValues) {
    return translatedValues.map((e) => CheckedPopupMenuItem<TEnum>(
      checked: selectedValue == e.enumValue,
      value: e.enumValue,
      child: Text(
        e.translation,
      ),
    )).toList();
  }

  void handleItemSelected(TEnum value) {
    onSelected?.call(value);
  }
}

class ItemPopupMenuFilterWithAllValue extends ItemPopupMenuFilter<int> {
  static int allValue = -1;

  final Function(int?)? onAllOrValueSelected;

  ItemPopupMenuFilterWithAllValue({
    Key? key,
    required String toolTipText,
    int? selectedValue,
    this.onAllOrValueSelected,
    required List<int> values,
    required PopupMenuItemText<int> itemText,
    List<int> exclude = const [],
    Icon icon = const Icon(Icons.keyboard_arrow_right, color: Color(0xFF8B8C8C), size: 20),
  }) : super(
    key: key,
    toolTipText: toolTipText,
    selectedValue: selectedValue ?? allValue,
    itemText: itemText,
    exclude: exclude,
    icon: icon,
    values: values..add(allValue),
  );

  @override
  List<TranslatedEnum<int>> getTranslatedValues(BuildContext context) {
    return EnumUtils.getTranslatedAndSortedEnumWithAllValue(allValue, 'All', values, itemText, exclude: exclude);
  }

  @override
  void handleItemSelected(int value) {
    if (onAllOrValueSelected == null) {
      return;
    }

    final valueToUse = value == allValue ? null : value;
    onAllOrValueSelected!(valueToUse);
  }
}
