import 'dart:async';

import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_bloc.freezed.dart';
part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, ResultState> {
  final AuthService _authService;
  final SessionBloc _sessionBloc;
  late final StreamSubscription _streamSubscription;

  SignInBloc(this._authService, this._sessionBloc) : super(const ResultState.idle()) {
    _streamSubscription = _authService.signInLoading.stream.listen((value) {
      isLoading = value;
      add(const SignInEvent.refresh());
    });

    on<_Authenticate>((event, emit) async {
      emit(const ResultState.loading());
      final result = await _authService.signIn(
        email: event.email,
        password: event.password,
      );
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

    on<_UpdatePassword>((event, emit) async {
      emit(const ResultState.loading());
      final result = await _authService.updatePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );
      result.when(
        success: (String data) {
          emit(const ResultState.data());
        },
        failure: (NetworkExceptions e) {
          emit(ResultState.error(error: e));
        },
      );
    });

    on<_Refresh>((event, emit) {
      emit(const ResultState.refresh());
    });
  }

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    await super.close();
  }

  bool isLoading = false;
}
