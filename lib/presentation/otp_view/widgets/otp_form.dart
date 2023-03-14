import 'package:buddy/colors.dart';
import 'package:flutter/material.dart';

import 'count_down.dart';
import 'otp_input.dart';

class OTPForm extends StatelessWidget {
  const OTPForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        const OTPInput(),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Code expires in',
              style: textTheme.bodyMedium!.copyWith(color: AppColors.grey7),
            ),
            const CountDownWidget(),
          ],
        ),
      ],
    );
  }
}

