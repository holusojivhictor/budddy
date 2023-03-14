import 'package:flutter/widgets.dart';

class NavigationBarItem {
  final Widget icon;
  final Widget activeIcon;
  final String title;
  final String? tooltip;

  const NavigationBarItem({
    required this.icon,
    Widget? activeIcon,
    required this.title,
    this.tooltip,
  }) : activeIcon = activeIcon ?? icon;
}
