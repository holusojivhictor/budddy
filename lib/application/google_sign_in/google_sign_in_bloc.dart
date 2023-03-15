import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_sign_in_bloc.freezed.dart';
part 'google_sign_in_event.dart';

class GoogleSignInBloc extends Bloc<GoogleSignInEvent, ResultState> {
  final AuthService _authService;
  final SessionBloc _sessionBloc;

  GoogleSignInBloc(this._authService, this._sessionBloc) : super(const ResultState.idle()) {
    on<_Authenticate>((event, emit) async {
      emit(const ResultState.loading());
      final result = await _authService.signInWithGoogle();
      result.when(
        success: (String data) {
          _sessionBloc.add(const SessionEvent.initStartup());
          emit(const ResultState.data());
        },
        failure: (NetworkExceptions e) {
          emit(ResultState.error(error: e));
        },
      );
    });
  }
}
