import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/models/models.dart';

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
