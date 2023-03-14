import 'package:buddy/colors.dart';
import 'package:flutter/material.dart';

class ModalSheetDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final Color color;

  const ModalSheetDivider({
    this.height = 2,
    this.thickness = 2,
    this.color = AppColors.grey2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      color: color,
    );
  }
}
