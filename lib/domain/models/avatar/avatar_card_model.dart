class AvatarCardModel {
  final String displayName;
  final String avatarSource;
  final bool isUser;

  const AvatarCardModel ({
    required this.displayName,
    required this.avatarSource,
    this.isUser = false,
  });
}
