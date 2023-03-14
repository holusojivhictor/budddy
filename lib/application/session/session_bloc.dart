import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_bloc.freezed.dart';
part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AuthService _authService;
  final BuddyAppService _appService;
  final MainTabBloc _mainTabBloc;

  SessionBloc(this._authService, this._appService, this._mainTabBloc) : super(const SessionState.unInitialized()) {
    on<_AppStarted>((event, emit) async {
      if (event.init) {
        await Future.delayed(const Duration(milliseconds: 3000));
      }
      await for (final userState in FirebaseAuth.instance.authStateChanges()) {
        if (userState != null) {
          await _appService.init();
          emit(const SessionState.authenticated());
          return;
        }
        break;
      }
      emit(const SessionState.unAuthenticated());
    });

    on<_LogOut>((event, emit) async {
      await _authService.signOut();
      emit(const SessionState.unAuthenticated());
      _mainTabBloc.add(const MainTabEvent.goToTab(index: 1));
    });

    on<_ForgotPassword>((event, emit) async {
      emit(const SessionState.forgotPassword());
    });

    on<_SignUp>((event, emit) async {
      emit(const SessionState.signUpState());
    });

    on<_SignIn>((event, emit) async {
      emit(const SessionState.signInState());
    });

    on<_verifyOTP>((event, emit) async {
      emit(const SessionState.otpVerificationState());
    });

    on<_InitStartup>((event, emit) async {
      await _appService.init();
      emit(const SessionState.authenticated());
    });
  }
}
