import 'package:buddy/colors.dart';
import 'package:flutter/material.dart';

class ModalSheetSeparator extends StatelessWidget {
  final bool hasMargin;
  const ModalSheetSeparator({Key? key, this.hasMargin = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: hasMargin ? 5 : 2),
        child: SizedBox(
          width: 65,
          height: 5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
