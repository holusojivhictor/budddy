import 'package:buddy/presentation/otp_view/widgets/otp_form.dart';
import 'package:buddy/presentation/shared/padded_text.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';

class OTPView extends StatelessWidget {
  const OTPView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(height: 30),
            _ViewHeader(
              phone: '08028283910',
            ),
            SizedBox(height: 20),
            OTPForm(),
          ],
        ),
      ),
    );
  }
}

class _ViewHeader extends StatelessWidget {
  const _ViewHeader({
    required this.phone,
  });

  final String phone;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PaddedText(
          'OTP code',
          style: textTheme.headlineSmall,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: Styles.edgeInsetHorizontal16,
          child: Text.rich(
            TextSpan(
              text: 'Enter the verification code sent',
              style: textTheme.bodyMedium,
              children: <TextSpan>[
                TextSpan(
                  text: '',
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
