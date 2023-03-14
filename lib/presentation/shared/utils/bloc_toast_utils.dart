import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'toast_utils.dart';

class BlocToastUtils {
  static void showToast(BuildContext context, Widget child) {
    final fToast = ToastUtils.of(context);

    fToast.showToast(
      child: child,
      gravity: ToastGravity.BOTTOM,
      toastDuration: ToastUtils.toastDuration,
    );
  }
}
