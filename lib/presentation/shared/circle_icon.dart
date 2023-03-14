import 'package:buddy/colors.dart';
import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    super.key,
    required this.icon,
    this.hasBackground = false,
  });

  final IconData icon;
  final bool hasBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: hasBackground ? AppColors.primary : Colors.transparent,
        border: hasBackground ? const Border() : Border.all(
          color: AppColors.grey4,
          width: 1.5,
        ),
      ),
      child: Icon(
        icon,
        color: hasBackground ? AppColors.grey1 : AppColors.grey7,
        size: 20,
      ),
    );
  }
}
