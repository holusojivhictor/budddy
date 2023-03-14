part of 'sign_up_bloc.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.verifyUser({
    required String code,
  }) = _VerifyUser;

  const factory SignUpEvent.register({
    required String email,
    required String phone,
    required String password,
  }) = _Register;

  const factory SignUpEvent.refresh() = _Refresh;
}
