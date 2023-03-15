part of 'buddy_bloc.dart';

@freezed
class BuddyState with _$BuddyState {
  const factory BuddyState.loading() = _LoadingState;

  const factory BuddyState.loaded({
    required String id,
    required String displayName,
    required String emailAddress,
    required String phoneNumber,
    required String avatarSource,
    required List<SportType> interests,
    required List<FriendCardModel> friends,
    @Default(false) bool isLoading,
  }) = _LoadedState;
}
