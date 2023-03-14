import 'package:buddy/colors.dart';
import 'package:flutter/material.dart';

class TitleTile extends StatelessWidget {
  final String title;
  final IconData? trailingIcon;
  final void Function()? onPressed;

  const TitleTile({
    Key? key,
    required this.title,
    this.trailingIcon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trailing = trailingIcon != null
        ? IconButton(
            onPressed: onPressed,
            icon: Icon(trailingIcon),
            color: AppColors.grey6,
            padding: const EdgeInsets.only(left: 10),
          )
        : null;

    return ListTile(
      visualDensity: const VisualDensity(vertical: 0),
      trailing: trailing,
      title: Text(
        title,
        style: theme.textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
      ),
    );
  }
}
