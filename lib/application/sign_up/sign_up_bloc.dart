import 'dart:async';

import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_bloc.freezed.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, ResultState> {
  final AuthService _authService;
  final SessionBloc _sessionBloc;
  late final StreamSubscription _streamSubscription;

  SignUpBloc(this._authService, this._sessionBloc) : super(const ResultState.idle()) {
    _streamSubscription = _authService.signUpLoading.stream.listen((value) {
      isLoading = value;
      add(const SignUpEvent.refresh());
    });

    on<_VerifyUser>((event, emit) async {
      emit(const ResultState.loading());
      final verificationId = await _authService.getSavedCode();
      final result = await _authService.linkCredential(
        verificationId: verificationId,
        code: event.code,
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

    on<_Register>((event, emit) async {
      emit(const ResultState.loading());
      final result = await _authService.signUp(
        email: event.email,
        phone: event.phone,
        password: event.password,
      );
      result.when(
        success: (String data) {
          _sessionBloc.add(const SessionEvent.onOTP());
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
