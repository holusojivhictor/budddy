import 'package:buddy/colors.dart';
import 'package:flutter/material.dart';

class SettingsSwitchListTile extends StatelessWidget {
  final bool value;
  final String title;
  final Widget? leadingIcon;
  final ValueChanged<bool>? onChanged;

  const SettingsSwitchListTile({
    Key? key,
    required this.title,
    required this.value,
    this.leadingIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: leadingIcon,
        visualDensity: const VisualDensity(vertical: 2),
        contentPadding: const EdgeInsets.only(left: 12),
        trailing: Switch.adaptive(
          activeColor: AppColors.primary,
          value: value,
          onChanged: onChanged != null ? (value) => onChanged!(value) : null,
        ),
      ),
    );
  }
}
