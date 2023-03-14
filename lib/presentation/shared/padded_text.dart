import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';

class PaddedText extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String? text;
  final TextAlign? textAlign;
  final TextStyle? style;

  const PaddedText(
    this.text, {
    Key? key,
    this.padding,
    this.textAlign,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding ?? Styles.edgeInsetHorizontal16,
      child: Text(
        text ?? '',
        textAlign: textAlign,
        style: style ?? theme.textTheme.headlineSmall,
      ),
    );
  }
}
