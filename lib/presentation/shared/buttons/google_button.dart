import 'package:buddy/domain/assets.dart';
import 'package:flutter/material.dart';

import 'primary_button.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    required this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PrimaryButton(
      isPrimary: false,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.getImagePath('google_icon.png'), height: 16),
          const SizedBox(width: 5),
          Text(
            'Google',
            style: textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
