part of 'buddies_bloc.dart';

@freezed
class BuddiesState with _$BuddiesState {
  const factory BuddiesState.loading() = _LoadingState;

  const factory BuddiesState.loaded({
    required List<BuddyCardModel> data,
  }) = _LoadedState;
}
