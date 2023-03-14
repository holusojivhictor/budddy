import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/app_constants.dart';
import 'package:buddy/domain/assets.dart';
import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/presentation/settings/widgets/policy_page.dart';
import 'package:buddy/presentation/settings/widgets/settings_switch_list_tile.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:buddy/presentation/shared/padded_text.dart';
import 'package:buddy/presentation/shared/popup_menu/item_popup_menu_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_list_tile.dart';

class AppSettingsCard extends StatelessWidget {
  const AppSettingsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingsListTile(
              title: 'Auto Dark Mode',
              trailing: ItemPopupMenuFilter<AutoThemeModeType>(
                toolTipText: 'Auto Theme Mode',
                selectedValue: state.themeMode,
                values: AutoThemeModeType.values,
                onSelected: (newVal) => context.read<SettingsBloc>().add(SettingsEvent.autoThemeModeTypeChanged(newValue: newVal)),
                icon: const Icon(Icons.expand_more),
                itemText: (val, _) => Assets.translateAutoThemeModeType(val),
              ),
            ),
            SettingsSwitchListTile(
              title: 'Dark Mode',
              value: state.currentTheme.darkMode,
              onChanged: state.themeMode == AutoThemeModeType.off
                  ? (newVal) => context.read<SettingsBloc>().add(SettingsEvent.themeChanged(newValue: Assets.translateThemeTypeBool(newVal))) : null,
            ),
            SettingsListTile(
              title: 'Language',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Assets.translateAppLanguageType(state.currentLanguage),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  ItemPopupMenuFilter<AppLanguageType>(
                    toolTipText: 'App Language',
                    selectedValue: state.currentLanguage,
                    values: AppLanguageType.values,
                    onSelected: (newVal) => context.read<SettingsBloc>().add(SettingsEvent.languageChanged(newValue: newVal)),
                    itemText: (val, _) => Assets.translateAppLanguageType(val),
                  ),
                ],
              ),
            ),
            SettingsSwitchListTile(
              title: 'Press back to exit',
              value: state.doubleBackToClose,
              onChanged: (newVal) => context.read<SettingsBloc>().add(SettingsEvent.doubleBackToCloseChanged(newValue: newVal)),
            ),
            SettingsListTile(
              title: 'Privacy Policy',
              trailing: const _PaddedIcon(),
              onTap: () => goToPage(context, const PolicyPage()),
            ),
            SettingsListTile(
              title: 'Version',
              trailing: PaddedText(
                state.appVersion,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaddedIcon extends StatelessWidget {
  const _PaddedIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Icon(Icons.keyboard_arrow_right, size: 20),
    );
  }
}
