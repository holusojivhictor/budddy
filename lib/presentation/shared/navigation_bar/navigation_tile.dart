import 'package:buddy/colors.dart';
import 'package:flutter/material.dart';

import 'navigation_bar_item.dart';

class NavigationTile extends StatelessWidget {
  final NavigationBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final IconThemeData? selectedIconTheme;
  final IconThemeData? unselectedIconTheme;
  final ColorTween? iconColorTween;
  final VoidCallback? onTap;
  final bool selected;

  const NavigationTile(
      this.item,
      this.animation,
      this.iconSize, {
        super.key,
        required this.selected,
        required this.selectedIconTheme,
        required this.unselectedIconTheme,
        this.iconColorTween,
        this.onTap,
      });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      tooltip: item.tooltip,
      selected: selected,
      container: true,
      child: InkResponse(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TileIcon(
              colorTween: iconColorTween!,
              animation: animation,
              iconSize: iconSize,
              selected: selected,
              item: item,
              selectedIconTheme: selectedIconTheme,
              unselectedIconTheme: unselectedIconTheme,
            ),
            _AnimatedBar(isActive: selected),
          ],
        ),
      ),
    );
  }
}

class _TileIcon extends StatelessWidget {
  const _TileIcon({
    required this.colorTween,
    required this.animation,
    required this.iconSize,
    required this.selected,
    required this.item,
    required this.selectedIconTheme,
    required this.unselectedIconTheme,
  });

  final ColorTween colorTween;
  final Animation<double> animation;
  final double iconSize;
  final bool selected;
  final NavigationBarItem item;
  final IconThemeData? selectedIconTheme;
  final IconThemeData? unselectedIconTheme;

  @override
  Widget build(BuildContext context) {
    final Color? iconColor = colorTween.evaluate(animation);
    final IconThemeData defaultIconTheme = IconThemeData(
      color: iconColor,
      size: iconSize,
    );
    final IconThemeData iconThemeData = IconThemeData.lerp(
      defaultIconTheme.merge(unselectedIconTheme),
      defaultIconTheme.merge(selectedIconTheme),
      animation.value,
    );

    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1.0,
      child: IconTheme(
        data: iconThemeData,
        child: selected ? item.activeIcon : item.icon,
      ),
    );
  }
}

class _AnimatedBar extends StatelessWidget {
  final bool isActive;

  const _AnimatedBar({
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(top: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
