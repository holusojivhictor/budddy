part of 'session_bloc.dart';

@freezed
class SessionState with _$SessionState {
  const factory SessionState.unInitialized() = _UnInitializedState;

  const factory SessionState.unAuthenticated() = _UnAuthenticatedState;

  const factory SessionState.signUpState() = _SignUpState;

  const factory SessionState.signInState() = _SignInState;

  const factory SessionState.forgotPassword() = _ForgotPasswordState;

  const factory SessionState.otpVerificationState() = _OTPVerificationState;

  const factory SessionState.authenticated() = _AuthenticatedState;
}
