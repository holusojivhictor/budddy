import 'dart:async';

import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buddy_bloc.freezed.dart';
part 'buddy_event.dart';
part 'buddy_state.dart';

class BuddyBloc extends Bloc<BuddyEvent, BuddyState> {
  final BuddyAppService _appService;
  final HomeBloc _homeBloc;

  BuddyBloc(this._appService, this._homeBloc) : super(const BuddyState.loading()) {
    on<_LoadBuddyFromId>(_mapLoadFromIdToState);
    on<_Connect>(_mapConnectToState);
  }

  // ignore: library_private_types_in_public_api
  _LoadedState get currentState => state as _LoadedState;

  BuddyState _buildInitialState(BuddyFileModel buddy) {
    return BuddyState.loaded(
      id: buddy.id,
      displayName: buddy.displayName,
      emailAddress: buddy.emailAddress,
      phoneNumber: buddy.phoneNumber,
      avatarSource: buddy.avatarSource,
      interests: buddy.sportInterests,
      friends: buddy.friends.map(FriendCardModel.fromModel).toList(),
    );
  }

  void _mapLoadFromIdToState(_LoadBuddyFromId event, Emitter<BuddyState> emit) {
    final buddy = _appService.getBuddyFromId(event.id);
    emit(_buildInitialState(buddy));
  }

  Future<void> _mapConnectToState(_Connect event, Emitter<BuddyState> emit) async {
    emit(currentState.copyWith.call(isLoading: true));
    await _appService.updateUserFriends(buddyId: event.id);

    _homeBloc.add(const HomeEvent.refresh());
    showToast.add(true);
    emit(currentState.copyWith.call(isLoading: false));
  }

  @override
  Future<void> close() async {
    await showToast.close();
    await super.close();
  }

  final StreamController<bool> showToast = StreamController.broadcast();
}
