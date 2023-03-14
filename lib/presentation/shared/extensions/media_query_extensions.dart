import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

extension MediaQueryExtensions on MediaQueryData {
  double getWidthForDialogs() {
    final deviceType = getDeviceType(size);
    var take = orientation == Orientation.portrait ? 1.5 : 2.5;
    switch (deviceType) {
      case DeviceScreenType.tablet:
      case DeviceScreenType.desktop:
        take = orientation == Orientation.portrait ? 2 : 3;
        break;
      default:
        break;
    }
    final width = size.width / take;
    return width;
  }

  double getHeightForDialogs(int itemCount, {double itemHeight = 65, double maxHeight = 300}) {
    final deviceType = getDeviceType(size);
    var max = maxHeight;
    switch (deviceType) {
      case DeviceScreenType.tablet:
      case DeviceScreenType.desktop:
        final exceeds = 500 * 100 / size.height > 75;
        if (exceeds) {
          max = size.height * 0.55;
        }
        break;
      default:
        final exceeds = maxHeight * 100 / size.height > 60;
        if (exceeds) {
          max = size.height * 0.55;
        }
        break;
    }

    final desiredHeight = itemHeight * itemCount;
    final heightToUse = desiredHeight >= max ? max : desiredHeight;
    return heightToUse;
  }

  double getHeightForDialogBox() {
    final deviceType = getDeviceType(size);
    var take = orientation == Orientation.portrait ? 5.7 : 3;
    switch (deviceType) {
      case DeviceScreenType.tablet:
      case DeviceScreenType.desktop:
        take = orientation == Orientation.portrait ? 8 : 6;
        break;
      default:
        break;
    }
    final width = size.height / take;
    return width;
  }
}
