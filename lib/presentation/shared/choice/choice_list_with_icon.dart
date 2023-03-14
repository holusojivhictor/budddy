import 'package:buddy/presentation/shared/utils/enum_utils.dart';
import 'package:flutter/material.dart';

import 'common_choice_button.dart';

typedef ChoiceButtonText<T> = String Function(T value, int index);
typedef ChoiceButtonIcon<T> = IconData Function(T value, int index);

class ChoiceListWithIcon<TEnum> extends StatelessWidget {
  final List<TEnum> selectedValues;
  final List<TEnum> values;
  final Function(TEnum)? onSelected;
  final List<TEnum> exclude;
  final ChoiceButtonText<TEnum> choiceText;
  final ChoiceButtonIcon<TEnum> iconData;
  final WrapAlignment alignment;

  const ChoiceListWithIcon({
    Key? key,
    this.selectedValues = const [],
    required this.values,
    this.onSelected,
    this.exclude = const [],
    this.alignment = WrapAlignment.center,
    required this.choiceText,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translatedValues = getTranslatedValues();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: alignment,
        spacing: 5,
        runSpacing: 14,
        children: getButtons(context, translatedValues),
      ),
    );
  }

  List<TranslatedEnumWithIcon<TEnum>> getTranslatedValues() {
    return EnumUtils.getTranslatedAndSortedEnumWithIcon<TEnum>(values, choiceText, iconData, exclude: exclude);
  }

  List<Widget> getButtons(BuildContext context, List<TranslatedEnumWithIcon<TEnum>> translatedValues) {
    return translatedValues.map((e) => _buildChoiceButton(context, e.enumValue, e.translation, e.iconData)).toList();
  }

  Widget _buildChoiceButton(BuildContext context, TEnum value, String valueText, IconData iconData) {
    final theme = Theme.of(context);
    final isSelected = selectedValues.isNotEmpty && selectedValues.contains(value);
    final textStyle = theme.textTheme.bodySmall!.copyWith(color: isSelected ? Colors.white : Colors.black);
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: CommonChoiceButton<TEnum>(
        value: value,
        isSelected: isSelected,
        valueText: valueText,
        textStyle: textStyle,
        iconData: iconData,
        onPressed: handleItemSelected,
      ),
    );
  }

  void handleItemSelected(TEnum value) {
    onSelected?.call(value);
  }
}
