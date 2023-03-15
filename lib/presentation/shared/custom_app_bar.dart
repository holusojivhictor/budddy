import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.automaticallyImplyLeading = true,
  });

  final String title;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      title: title.isNotEmpty ? Text(
        title,
        textAlign: TextAlign.center,
        style: theme.textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
      ) : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
