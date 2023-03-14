import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_tab_bloc.freezed.dart';
part 'main_tab_event.dart';
part 'main_tab_state.dart';

class MainTabBloc extends Bloc<MainTabEvent, MainTabState> {
  MainTabBloc() : super(const MainTabState.initial(0)) {
    on<_GoToTab>(_mapToTabToState);
  }

  void _mapToTabToState(_GoToTab event, Emitter<MainTabState> emit) {
    if (event.index < 0) {
      emit(state);
    }
    emit(state.copyWith(currentSelectedTab: event.index));
  }
}
