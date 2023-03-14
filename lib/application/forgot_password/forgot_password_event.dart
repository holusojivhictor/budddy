part of 'forgot_password_bloc.dart';

@freezed
class ForgotPasswordEvent with _$ForgotPasswordEvent {
  const factory ForgotPasswordEvent.sendResetEmail({
    required String email,
  }) = _SendResetEmail;

  const factory ForgotPasswordEvent.verifyCode({
    required String code,
  }) = _VerifyCode;

  const factory ForgotPasswordEvent.resetPassword({
    required String newPassword,
  }) = _ResetPassword;

  const factory ForgotPasswordEvent.refresh() = _Refresh;
}
