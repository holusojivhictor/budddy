import 'package:buddy/presentation/shared/avatars/avatar_preview.dart';
import 'package:buddy/presentation/shared/padded_text.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';

class BodyTopView extends StatelessWidget {
  final String displayName;
  final String avatarSource;

  const BodyTopView({
    Key? key,
    required this.displayName,
    required this.avatarSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        AvatarPreview(
          label: 'Profile picture',
          image: avatarSource,
        ),
        PaddedText(
          displayName,
          padding: Styles.edgeInsetAll5,
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
