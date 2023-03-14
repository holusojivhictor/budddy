import 'package:flutter/material.dart';

class BottomSheetTitle extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;

  const BottomSheetTitle({
    Key? key,
    required this.title,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Text(
        title,
        style: textStyle ?? theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
