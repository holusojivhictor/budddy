import 'package:buddy/colors.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Color? textColor;
  final BorderSide? side;
  final Widget? child;
  final bool hasLoading;
  final bool enabled;

  const PrimaryButton({
    Key? key,
    this.text = '',
    required this.onPressed,
    this.isPrimary = true,
    this.backgroundColor,
    this.contentPadding,
    this.padding = const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
    this.borderRadius = 30,
    this.hasLoading = false,
    this.enabled = true,
    this.textStyle,
    this.textColor,
    this.child,
    this.side,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textChild = Text(
      text,
      style: textStyle ?? theme.textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w600,
        color: textColor ?? (enabled ? isPrimary ? AppColors.white : AppColors.primary : AppColors.white.withOpacity(0.5)),
      ),
    );

    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: backgroundColor != null
              ? MaterialStateProperty.all(backgroundColor)
              : MaterialStateProperty.all(enabled ? isPrimary ? AppColors.primary : Colors.transparent : AppColors.primary.withOpacity(0.5)),
          shape: MaterialStateProperty.all(
            StadiumBorder(
              side: side ?? (isPrimary ? BorderSide.none : const BorderSide(color: AppColors.primary, width: 1.5,
              )),
            ),
          ),
          padding: MaterialStateProperty.all(hasLoading ? Styles.inactiveButtonPadding : contentPadding ?? Styles.edgeInsetAll16),
        ),
        onPressed: hasLoading || !enabled ? null : onPressed,
        child: hasLoading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 1.5, color: AppColors.white))
            : child ?? textChild,
      ),
    );
  }
}
