import 'package:buddy/colors.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:buddy/presentation/shared/extensions/media_query_extensions.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';

class SecondaryDialog extends StatelessWidget {
  final String titleText;
  final String contentText;
  final String? actionText;
  final String? cancelText;
  final void Function()? actionOnPressed;
  final void Function()? cancelOnPressed;

  const SecondaryDialog({
    Key? key,
    required this.titleText,
    required this.contentText,
    this.actionText,
    this.cancelText,
    this.actionOnPressed,
    this.cancelOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return AlertDialog(
      elevation: 10,
      alignment: Alignment.center,
      shape: Styles.alertDialogShape,
      surfaceTintColor: AppColors.tertiary,
      title: Text(
        titleText,
        textAlign: TextAlign.center,
        style: theme.textTheme.headlineSmall!.copyWith(color: AppColors.error, fontSize: 22),
      ),
      content: SizedBox(
        width: mediaQuery.getWidthForDialogs(),
        height: mediaQuery.getHeightForDialogs(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              contentText,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium!.copyWith(color: AppColors.grey6),
            ),
            const SizedBox(height: 5),
            PrimaryButton(
              borderRadius: 8,
              padding: const EdgeInsets.only(top: 5),
              contentPadding: EdgeInsets.zero,
              text: cancelText ?? 'Close',
              onPressed: cancelOnPressed != null ? () => cancelOnPressed!() : () => Navigator.of(context).pop(),
            ),
            PrimaryButton(
              isPrimary: false,
              text: actionText ?? 'Okay',
              textColor: AppColors.error,
              borderRadius: 8,
              padding: const EdgeInsets.only(top: 5),
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              onPressed: actionOnPressed != null ? () => actionOnPressed!() : () => Navigator.of(context).pop(),
              side: Styles.alertButtonBorderSide,
            ),
          ],
        ),
      ),
    );
  }
}

