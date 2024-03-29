import 'package:buddy/colors.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/presentation/shared/avatars/avatar_preview.dart';
import 'package:flutter/material.dart';

class AvatarListPreview extends StatelessWidget {
  final String image;
  final String displayName;

  const AvatarListPreview({
    Key? key,
    required this.image,
    required this.displayName,
  }) : super(key: key);

  AvatarListPreview.item({
    Key? key,
    required AvatarCardModel model,
  })  : image = model.avatarSource,
        displayName = model.displayName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSvg = image.contains('api.dicebear.com');

    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Column(
        children: [
          AvatarPreview(
            height: 52,
            image: image,
            label: 'User avatar',
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSvg ? Border.all(color: AppColors.primary, width: 1.5) : null,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            displayName,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
