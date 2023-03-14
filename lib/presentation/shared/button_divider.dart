import 'package:flutter/material.dart';

class ButtonDivider extends StatelessWidget {
  const ButtonDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              endIndent: 15,
            ),
          ),
          Text(dividerText),
          const Expanded(
            child: Divider(
              indent: 15,
            ),
          ),
        ],
      ),
    );
  }
}
