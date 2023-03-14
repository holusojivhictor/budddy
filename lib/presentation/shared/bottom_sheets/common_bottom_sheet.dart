import 'package:buddy/presentation/shared/modal_sheet_separator.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_title.dart';
import 'common_bottom_sheet_buttons.dart';
import 'modal_sheet_divider.dart';

class CommonBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final Function? onOk;
  final Function? onCancel;
  final bool showTitle;
  final bool showOkButton;
  final bool showCancelButton;
  final bool showDivider;
  final TextStyle? textStyle;
  final Decoration? decoration;

  const CommonBottomSheet({
    Key? key,
    required this.title,
    required this.child,
    this.showTitle = true,
    this.showOkButton = true,
    this.showCancelButton = true,
    this.showDivider = false,
    this.onOk,
    this.onCancel,
    this.textStyle,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const ModalSheetSeparator(),
            if (showTitle)
              BottomSheetTitle(
                title: title,
                textStyle: textStyle,
              ),
            child,
            if (showDivider)
              const ModalSheetDivider(),
            if (showOkButton || showCancelButton)
              CommonBottomSheetButtons(
                showOkButton: showOkButton,
                showCancelButton: showCancelButton,
                onOk: onOk,
                onCancel: onCancel,
              ),
          ],
        ),
      ),
    );
  }
}
