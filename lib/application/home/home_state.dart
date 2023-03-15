part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _LoadingState;

  const factory HomeState.loaded({
    required String displayName,
    required String emailAddress,
    String? phoneNumber,
    required String avatarSource,
    required List<SportType> interests,
    required List<FriendCardModel> friends,
    required List<SportType> sportTypes,
    required List<SportType> tempSportTypes,
  }) = _LoadedState;
}
