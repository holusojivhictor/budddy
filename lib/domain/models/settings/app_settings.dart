import 'package:buddy/domain/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
class AppSettings with _$AppSettings {
  factory AppSettings({
    required AppThemeType appTheme,
    required AppLanguageType appLanguage,
    required bool useDarkMode,
    required bool isFirstInstall,
    required bool doubleBackToClose,
    required AutoThemeModeType themeMode,
  }) = _AppSettings;

  const AppSettings._();

  factory AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);
}
