import 'package:buddy/colors.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:buddy/presentation/shared/extensions/media_query_extensions.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';

class PrimaryDialog extends StatelessWidget {
  final String titleText;
  final String contentText;
  final String? actionText;
  final void Function()? actionOnPressed;

  const PrimaryDialog({
    Key? key,
    required this.titleText,
    required this.contentText,
    this.actionText,
    this.actionOnPressed,
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
      title: SizedBox(
        child: Text(
          titleText,
          style: theme.textTheme.headlineSmall!.copyWith(color: const Color(0xFF231F20), fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      content: SizedBox(
        width: mediaQuery.getWidthForDialogs(),
        height: mediaQuery.getHeightForDialogs(1) + 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                contentText,
                style: theme.textTheme.bodyMedium!.copyWith(color: AppColors.grey7),
              ),
            ),
            const SizedBox(height: 5),
            PrimaryButton(
              borderRadius: 8,
              isPrimary: false,
              padding: const EdgeInsets.only(top: 5),
              contentPadding: EdgeInsets.zero,
              text: actionText ?? 'Okay',
              onPressed: actionOnPressed != null ? () => actionOnPressed!() : () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
