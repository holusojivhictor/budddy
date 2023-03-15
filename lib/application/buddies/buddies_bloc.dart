import 'package:buddy/domain/models/models.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buddies_bloc.freezed.dart';
part 'buddies_event.dart';
part 'buddies_state.dart';

class BuddiesBloc extends Bloc<BuddiesEvent, BuddiesState> {
  final BuddyAppService _appService;

  BuddiesBloc(this._appService) : super(const BuddiesState.loading()) {
    on<_Init>(_mapInitToState);
  }

  // ignore: library_private_types_in_public_api
  _LoadedState get currentState => state as _LoadedState;

  BuddiesState _buildInitialState() {
    final isLoaded = state is _LoadedState;

    var data = _appService.getBuddiesForCard();

    if (!isLoaded) {
      return BuddiesState.loaded(data: data);
    }

    final s = currentState.copyWith.call(
      data: data,
    );

    return s;
  }

  void _mapInitToState(_Init event, Emitter<BuddiesState> emit) {
    emit(_buildInitialState());
  }
}
