import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/models/models.dart';

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

  factory FriendCardModel.fromModel(FriendModel model) {
    return FriendCardModel(
      id: model.id,
      displayName: model.displayName,
      avatarSource: model.avatarSource,
      interests: model.sportInterests,
    );
  }
}
