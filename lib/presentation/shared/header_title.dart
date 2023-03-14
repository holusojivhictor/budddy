import 'package:flutter/material.dart';

import 'padded_text.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PaddedText(
          title,
          style: textTheme.headlineSmall,
        ),
        const SizedBox(height: 10),
        PaddedText(
          subtitle,
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
