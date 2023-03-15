import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';

class DisplayChipWithIcon extends StatelessWidget {
  final String valueText;
  final IconData iconData;

  const DisplayChipWithIcon({
    Key? key,
    required this.valueText,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.15),
        borderRadius: Styles.choiceButtonBorderRadius,
      ),
      child: Padding(
        padding: Styles.edgeInsetSymmetric8,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ChoiceCircle(
              iconData: iconData,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: Text(
                valueText,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceCircle extends StatelessWidget {
  final IconData iconData;

  const _ChoiceCircle({
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(iconData, size: 15),
    );
  }
}
