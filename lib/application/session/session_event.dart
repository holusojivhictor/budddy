part of 'session_bloc.dart';

@freezed
class SessionEvent with _$SessionEvent {
  const factory SessionEvent.appStarted({required bool init}) = _AppStarted;

  const factory SessionEvent.onLogout() = _LogOut;

  const factory SessionEvent.onForgotPassword() = _ForgotPassword;

  const factory SessionEvent.onSignUp() = _SignUp;

  const factory SessionEvent.onSignIn() = _SignIn;

  const factory SessionEvent.onOTP() = _verifyOTP;

  const factory SessionEvent.initStartup() = _InitStartup;
}
