import 'dart:async';

import 'package:buddy/domain/models/models.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_bloc.freezed.dart';
part 'forgot_password_event.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ResultState> {
  final AuthService _authService;
  late final StreamSubscription _streamSubscription;

  ForgotPasswordBloc(this._authService) : super(const ResultState.idle()) {
    _streamSubscription = _authService.signInLoading.stream.listen((value) {
      isLoading = value;
      add(const ForgotPasswordEvent.refresh());
    });

    on<_SendResetEmail>((event, emit) async {
      emit(const ResultState.loading());
      final result = await _authService.sendResetEmail(
        email: event.email,
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

    on<_VerifyCode>((event, emit) async {
      emit(const ResultState.loading());
      final result = await _authService.verifyCode(
        code: event.code,
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

    on<_ResetPassword>((event, emit) async {
      emit(const ResultState.loading());
      final code = await _authService.getSavedCode();
      final result = await _authService.resetPassword(
        code: code,
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
