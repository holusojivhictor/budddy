import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String displayName;
  final String emailAddress;
  final String? phoneNumber;
  final String avatarSource;

  const UserModel({
    required this.id,
    required this.displayName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.avatarSource,
  });

  factory UserModel.empty() {
    return const UserModel(
      id: '',
      displayName: '',
      emailAddress: '',
      phoneNumber: null,
      avatarSource: '',
    );
  }

  factory UserModel.fromFB(User? user) {
    if (user == null) return UserModel.empty();

    return UserModel(
      id: user.uid,
      displayName: user.displayName!,
      emailAddress: user.email!,
      phoneNumber: user.phoneNumber,
      avatarSource: user.photoURL!,
    );
  }
}
