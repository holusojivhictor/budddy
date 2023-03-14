part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.init() = _Init;

  const factory HomeEvent.sportTypesChanged(SportType type) = _SportTypesChanged;

  const factory HomeEvent.applyFilterChanges() = _ApplyFilterChanges;

  const factory HomeEvent.refresh() = _Refresh;
}
