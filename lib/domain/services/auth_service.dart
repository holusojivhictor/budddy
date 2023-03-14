import 'dart:async';

import 'package:buddy/domain/models/models.dart';

abstract class AuthService {
  StreamController<bool> get signUpLoading;

  StreamController<bool> get signInLoading;

  UserModel get currentUser;

  Future<String> getSavedCode();

  Future<ApiResult<String>> linkCredential({
    required String verificationId,
    required String code,
  });

  Future<ApiResult<String>> signUp({
    required String email,
    required String phone,
    required String password,
  });

  Future<ApiResult<String>> signIn({
    required String email,
    required String password,
  });

  Future<void> updateUser({
    required String email,
    required String displayName,
  });

  Future<ApiResult<String>> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<ApiResult<String>> sendResetEmail({
    required String email,
  });

  Future<ApiResult<String>> verifyCode({
    required String code,
  });

  Future<ApiResult<String>> resetPassword({
    required String code,
    required String newPassword,
  });

  Future<ApiResult<String>> signInWithGoogle();

  Future<void> signOut();
}
