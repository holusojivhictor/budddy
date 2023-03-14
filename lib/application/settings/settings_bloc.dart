import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsService _settingsService;
  final DeviceInfoService _deviceInfoService;
  final MainBloc _mainBloc;

  SettingsBloc(
      this._settingsService,
      this._deviceInfoService,
      this._mainBloc,
      ) : super(const SettingsState.loading()) {
    on<_Init>(_mapInitToState);
    on<_ThemeChanged>(_mapThemeChangedToState);
    on<_LanguageChanged>(_mapLanguageChangedToState);
    on<_DoubleBackToCloseChanged>(_mapDoubleBackToCloseToState);
    on<_AutoThemeModeTypeChanged>(_mapAutoThemeModeChangedToState);
  }

  // ignore: library_private_types_in_public_api
  _LoadedState get currentState => state as _LoadedState;

  void _mapInitToState(_Init event, Emitter<SettingsState> emit) async {
    final settings = _settingsService.appSettings;

    emit(SettingsState.loaded(
      currentTheme: settings.appTheme,
      currentLanguage: settings.appLanguage,
      appVersion: _deviceInfoService.version,
      doubleBackToClose: settings.doubleBackToClose,
      themeMode: settings.themeMode,
    ));
  }

  void _mapThemeChangedToState(_ThemeChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.appTheme) {
      emit(currentState);
    }
    _settingsService.appTheme = event.newValue;
    _mainBloc.add(MainEvent.themeChanged(newValue: event.newValue));
    emit(currentState.copyWith.call(currentTheme: event.newValue));
  }

  void _mapLanguageChangedToState(_LanguageChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.language) {
      emit(currentState);
    }
    _settingsService.language = event.newValue;
    emit(currentState.copyWith.call(currentLanguage: event.newValue));
  }

  void _mapDoubleBackToCloseToState(_DoubleBackToCloseChanged event, Emitter<SettingsState> emit) {
    _settingsService.doubleBackToClose = event.newValue;
    emit(currentState.copyWith.call(doubleBackToClose: event.newValue));
  }

  void _mapAutoThemeModeChangedToState(_AutoThemeModeTypeChanged event, Emitter<SettingsState> emit) {
    if (event.newValue == _settingsService.autoThemeMode) {
      emit(currentState);
    }
    _settingsService.autoThemeMode = event.newValue;
    _mainBloc.add(MainEvent.themeModeChanged(newValue: event.newValue));
    emit(currentState.copyWith.call(themeMode: event.newValue));
  }

  bool get doubleBackToClose => _settingsService.doubleBackToClose;
}
