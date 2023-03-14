import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/models/models.dart';

class BuddyCardModel {
  final String id;
  final String displayName;
  final String avatarSource;
  final List<SportType> interests;
  final List<FriendCardModel> friends;

  const BuddyCardModel ({
    required this.id,
    required this.displayName,
    required this.avatarSource,
    required this.interests,
    required this.friends,
  });
}
