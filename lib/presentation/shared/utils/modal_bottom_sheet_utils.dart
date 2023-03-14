import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/presentation/home/widgets/interests_bottom_sheet.dart' as interests;
import 'package:flutter/material.dart';

class ModalBottomSheetUtils {
  static Widget getBottomSheetFromEndDrawerItemType(BuildContext context, EndDrawerItemType? type) {
    switch (type) {
      case EndDrawerItemType.interests:
        return const interests.InterestsBottomSheet();
      default:
        throw Exception('Type = $type is not mapped');
    }
  }

  static Future<void> showAppModalBottomSheet(BuildContext context, EndDrawerItemType type) async {
    await showModalBottomSheet(
      context: context,
      elevation: 0,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => getBottomSheetFromEndDrawerItemType(context, type),
    );
  }
}
