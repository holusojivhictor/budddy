import 'dart:async';

import 'package:buddy/domain/extensions/string_extensions.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceImpl implements AuthService {
  final _auth = FirebaseAuth.instance;
  final _verificationCodeKey = 'VerificationCodeKey';

  final collection = FirebaseFirestore.instance.collection('buddies');

  @override
  Future<String> getSavedCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_verificationCodeKey) ?? '';
  }

  @override
  Future<ApiResult<String>> linkCredential({
    required String verificationId,
    required String code,
  }) async {
    signUpLoading.add(true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );
      await _auth.currentUser?.linkWithCredential(credential);
      await collection.add(_toLocalForDoc(currentUser).toJson());
      signUpLoading.add(false);
      return const ApiResult.success(data: 'Verification successful');
    } catch (e) {
      signUpLoading.add(false);
      return ApiResult.failure(error: NetworkExceptions.getException(e));
    }
  }

  @override
  Future<ApiResult<String>> signUp({
    required String email,
    required String phone,
    required String password,
  }) async {
    signUpLoading.add(true);
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _verifyNumber(phone: phone);
      await _updateNameAndAvatar(email.displayName);
      signUpLoading.add(false);
      return const ApiResult.success(data: 'Sign up successful');
    } catch (e) {
      signUpLoading.add(false);
      return ApiResult.failure(error: NetworkExceptions.getException(e));
    }
  }

  @override
  Future<ApiResult<String>> signIn({
    required String email,
    required String password,
  }) async {
    signInLoading.add(true);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      signInLoading.add(false);
      return const ApiResult.success(data: "Sign in successful");
    } catch (e) {
      signInLoading.add(false);
      return ApiResult.failure(error: NetworkExceptions.getException(e));
    }
  }

  @override
  UserModel get currentUser => UserModel.fromFB(_auth.currentUser);

  @override
  Future<void> updateUser({
    required String email,
    required String displayName,
  }) async {
    await _auth.currentUser?.updateEmail(email);
    await _auth.currentUser?.updateDisplayName(displayName);
  }

  @override
  Future<ApiResult<String>> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    signInLoading.add(true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: currentUser.emailAddress,
        password: currentPassword,
      );
      await _auth.currentUser?.updatePassword(newPassword);
      signInLoading.add(false);
      return const ApiResult.success(data: "Password updated successfully");
    } catch (e) {
      signInLoading.add(false);
      return ApiResult.failure(error: NetworkExceptions.getException(e));
    }
  }

  @override
  Future<ApiResult<String>> resetPassword({
    required String code,
    required String newPassword,
  }) async {
    signInLoading.add(true);
    try {
      await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
      signInLoading.add(false);
      return const ApiResult.success(data: "Password reset successful");
    } catch (e) {
      signInLoading.add(false);
      return ApiResult.failure(error: NetworkExceptions.getException(e));
    }
  }

  @override
  Future<ApiResult<String>> sendResetEmail({required String email}) async {
    signInLoading.add(true);
    try {
      await _auth.sendPasswordResetEmail(email: email);
      signInLoading.add(false);
      return const ApiResult.success(data: "Email containing code sent");
    } catch (e) {
      signInLoading.add(false);
      return ApiResult.failure(error: NetworkExceptions.getException(e));
    }
  }

  @override
  Future<ApiResult<String>> verifyCode({required String code}) async {
    signInLoading.add(true);
    try {
      final data = await _auth.verifyPasswordResetCode(code);
      final userEmail = _auth.currentUser?.email;
      if (data != userEmail) {
        return const ApiResult.failure(error: NetworkExceptions.defaultError('Incorrect email provided.'));
      }
      await _saveCode(code);
      signInLoading.add(false);
      return const ApiResult.success(data: 'Code verification successful');
    } catch (e) {
      signInLoading.add(false);
      return ApiResult.failure(error: NetworkExceptions.getException(e));
    }
  }

  @override
  Future<ApiResult<String>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      await collection.add(_toLocalForDoc(currentUser).toJson());
      return const ApiResult.success(data: "Sign in with Google successful");
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getException(e));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _verifyNumber({required String phone}) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 0),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          throw NetworkExceptions.getException(e);
        },
        codeSent: (String verificationId, int? resendToken) async {
          await _saveCode(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _updateNameAndAvatar(String displayName) async {
    final avatar = _generateAvatar(displayName);
    await _auth.currentUser?.updateDisplayName(displayName);
    await _auth.currentUser?.updatePhotoURL(avatar);
  }

  String _generateAvatar(String seed) {
    final avatar = DiceBearBuilder(
      seed: seed,
      sprite: DiceBearSprite.bottts,
    ).build();
    return avatar.svgUri.toString();
  }

  Future<void> _saveCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_verificationCodeKey, code);
  }

  BuddyFileModel _toLocalForDoc(UserModel model) {
    return BuddyFileModel(
      id: model.id,
      displayName: model.displayName,
      emailAddress: model.emailAddress,
      phoneNumber: model.phoneNumber,
      avatarSource: model.avatarSource,
      sportInterests: [],
      friends: [],
    );
  }

  @override
  final StreamController<bool> signUpLoading = StreamController.broadcast();

  @override
  final StreamController<bool> signInLoading = StreamController.broadcast();
}
