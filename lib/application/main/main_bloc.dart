import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_bloc.freezed.dart';
part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final LoggingService _logger;
  final SettingsService _settingsService;
  final DeviceInfoService _deviceInfoService;

  MainBloc(this._logger, this._settingsService, this._deviceInfoService) : super(const _MainLoadingState()) {
    on<_Init>(_mapInitToState);
    on<_ThemeChanged>(_mapThemeChangedToState);
    on<_ThemeModeChanged>(_mapThemeModeChangedToState);
  }

  MainState _loadedState(AppThemeType theme, AutoThemeModeType autoThemeMode, {bool isInitialized = true}) {
    return MainState.loaded(
      appTitle: _deviceInfoService.appName,
      initialized: isInitialized,
      theme: theme,
      autoThemeMode: autoThemeMode,
      firstInstall: _settingsService.isFirstInstall,
      versionChanged: _deviceInfoService.versionChanged,
    );
  }

  void _logInfo() {
    _logger.info(runtimeType, '_init: Is first install = ${_settingsService.isFirstInstall}' '-- versionChanged = ${_deviceInfoService.versionChanged}');
  }

  Future<void> _mapInitToState(_Init event, Emitter<MainState> emit, {bool init = true}) async {
    _logger.info(runtimeType, '_init: Initializing all...');

    final settings = _settingsService.appSettings;

    _logInfo();

    final state = _loadedState(settings.appTheme, settings.themeMode, isInitialized: init);

    emit(state);
  }

  Future<void> _mapThemeChangedToState(_ThemeChanged event, Emitter<MainState> emit) async {
    _logInfo();

    emit(_loadedState(event.newValue, _settingsService.autoThemeMode, isInitialized: true));
  }

  Future<void> _mapThemeModeChangedToState(_ThemeModeChanged event, Emitter<MainState> emit) async {
    _logInfo();

    emit(_loadedState(_settingsService.appTheme, event.newValue, isInitialized: true));
  }
}
