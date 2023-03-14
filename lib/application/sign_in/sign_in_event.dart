part of 'sign_in_bloc.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.authenticate({
    required String email,
    required String password,
  }) = _Authenticate;

  const factory SignInEvent.updatePassword({
    required String currentPassword,
    required String newPassword,
  }) = _UpdatePassword;

  const factory SignInEvent.refresh() = _Refresh;
}
