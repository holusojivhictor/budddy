import 'dart:async';

import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BuddyAppService _appService;
  late final StreamSubscription _streamSubscription;

  HomeBloc(this._appService) : super(const HomeState.loading()) {
    _streamSubscription = _appService.isLoading.stream.listen((value) {
      isLoading = value;
    });

    on<_Init>(_mapInitToState);
    on<_SportTypesChanged>(_mapSportTypesChangedToState);
    on<_ApplyFilterChanges>(_mapApplyFilterChangesToState);
    on<_Refresh>(_mapRefreshToState);
  }

  // ignore: library_private_types_in_public_api
  _LoadedState get currentState => state as _LoadedState;

  HomeState _buildInitialState({
    List<SportType> sportTypes = const [],
  }) {
    final isLoaded = state is _LoadedState;
    final user = _appService.getUserForProfile();

    if (!isLoaded) {
      final selectedSportTypes = <SportType>[];
      return HomeState.loaded(
        displayName: user.displayName,
        emailAddress: user.emailAddress,
        phoneNumber: user.phoneNumber,
        avatarSource: user.avatarSource,
        interests: user.interests,
        friends: user.friends,
        sportTypes: selectedSportTypes,
        tempSportTypes: selectedSportTypes,
      );
    }

    final s = currentState.copyWith.call(
      displayName: user.displayName,
      emailAddress: user.emailAddress,
      phoneNumber: user.phoneNumber,
      avatarSource: user.avatarSource,
      interests: user.interests,
      friends: user.friends,
      sportTypes: sportTypes,
      tempSportTypes: sportTypes,
    );

    return s;
  }

  void _mapInitToState(_Init event, Emitter<HomeState> emit) {
    emit(_buildInitialState());
  }

  void _mapSportTypesChangedToState(_SportTypesChanged event, Emitter<HomeState> emit) {
    var types = <SportType>[];
    if (currentState.tempSportTypes.contains(event.type)) {
      types = currentState.tempSportTypes.where((t) => t != event.type).toList();
    } else {
      types = currentState.tempSportTypes + [event.type];
    }
    final state = currentState.copyWith.call(tempSportTypes: types);
    emit(state);
  }

  void _mapApplyFilterChangesToState(_ApplyFilterChanges event, Emitter<HomeState> emit) {
    final state = _buildInitialState(
      sportTypes: currentState.tempSportTypes,
    );
    emit(state);
  }

  void _mapRefreshToState(_Refresh event, Emitter<HomeState> emit) {
    final resetState = _buildInitialState();
    emit(resetState);
  }

  Future<void> updateInterests(List<SportType> types) async {
    await _appService.updateUserInterests(interests: types);
    add(const HomeEvent.refresh());
  }

  Future<void> updateUserProfile({
    required String email,
    required String displayName,
  }) async {
    await _appService.updateCurrentUser(displayName, email);
    add(const HomeEvent.refresh());
  }

  bool get hasInterests => _appService.getUserForProfile().interests.isNotEmpty;
  bool isLoading = false;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    await super.close();
  }
}
