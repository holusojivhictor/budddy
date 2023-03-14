import 'package:buddy/colors.dart';
import 'package:buddy/presentation/shared/circle_icon.dart';
import 'package:flutter/material.dart';

class BorderedInfoContainer extends StatelessWidget {
  final String title;
  const BorderedInfoContainer({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleIcon(
            icon: Icons.wifi_channel_rounded,
            hasBackground: true,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.variantGrey1),
            ),
          ),
        ],
      ),
    );
  }
}
