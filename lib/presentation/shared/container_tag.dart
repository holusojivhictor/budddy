import 'package:buddy/colors.dart';
import 'package:flutter/material.dart';

class ContainerTag extends StatelessWidget {
  final Color color;
  final bool hasBorder;
  final String tagText;
  final TextStyle? style;

  const ContainerTag({
    Key? key,
    required this.tagText,
    this.color = Colors.white,
    this.hasBorder = false,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: hasBorder ? Colors.transparent : color,
        border: hasBorder ? Border.all(color: AppColors.grey5) : const Border(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(tagText,
        textAlign: TextAlign.center,
        style: style ?? Theme.of(context).textTheme.bodySmall!.copyWith(
          color: AppColors.variantGrey2,
        ),
      ),
    );
  }
}
