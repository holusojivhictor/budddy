import 'package:buddy/domain/enums/enums.dart';

class UserProfileModel {
  final String displayName;
  final String emailAddress;
  final String phoneNumber;
  final String avatarSource;
  final List<SportType> interests;
  final List<FriendCardModel> friends;

  const UserProfileModel({
    required this.displayName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.avatarSource,
    required this.interests,
    required this.friends,
  });
}

class FriendCardModel {
  final String id;
  final String displayName;
  final String avatarSource;
  final List<SportType> interests;

  const FriendCardModel ({
    required this.id,
    required this.displayName,
    required this.avatarSource,
    required this.interests,
  });
}

