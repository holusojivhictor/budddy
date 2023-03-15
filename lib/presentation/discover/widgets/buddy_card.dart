import 'package:buddy/colors.dart';
import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/presentation/buddy/buddy_page.dart';
import 'package:buddy/presentation/shared/avatars/avatar_preview.dart';
import 'package:buddy/presentation/shared/cards/custom_card.dart';
import 'package:buddy/presentation/shared/container_tag.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';

class BuddyCard extends StatelessWidget {
  final String id;
  final String displayName;
  final String avatarSource;
  final List<SportType> interests;
  final int friendsLength;

  final bool withElevation;

  const BuddyCard({
    Key? key,
    required this.id,
    required this.displayName,
    required this.avatarSource,
    required this.interests,
    required this.friendsLength,
    this.withElevation = true,
  }) : super(key: key);

  BuddyCard.item({
    Key? key,
    required BuddyCardModel buddy,
    this.withElevation = true,
  })  : id = buddy.id,
        displayName = buddy.displayName,
        avatarSource = buddy.avatarSource,
        interests = buddy.interests,
        friendsLength = buddy.friends.length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height / 5;
    if (height > 220) {
      height = 220;
    } else if (height < 160) {
      height = 160;
    }
    final isSvg = avatarSource.contains('api.dicebear.com');

    return InkWell(
      onTap: () => _goToBuddyPage(context),
      borderRadius: Styles.defaultShapeRadius,
      overlayColor: MaterialStateProperty.all(AppColors.grey3.withOpacity(0.3)),
      child: CustomCard(
        margin: Styles.edgeInsetAll10,
        elevation: withElevation ? 3 : 0,
        borderRadius: Styles.defaultShapeRadius,
        child: Padding(
          padding: Styles.edgeInsetAll5,
          child: Container(
            padding: Styles.edgeInsetAll3,
            decoration: const BoxDecoration(
              borderRadius: Styles.defaultShapeRadius,
            ),
            height: height,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              fit: StackFit.loose,
              children: [
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    height: height * 0.8,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: Styles.defaultCardBorderRadius,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          displayName,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 10),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _DividerColumn(
                                title: 'Interests',
                                length: interests.length,
                              ),
                              const VerticalDivider(
                                indent: 4,
                                endIndent: 4,
                                width: 1,
                                thickness: 1.5,
                              ),
                              _DividerColumn(
                                title: 'Friends',
                                length: friendsLength,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const ContainerTag(
                          hasBorder: true,
                          tagText: 'Verified',
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                AvatarPreview(
                  height: height / 2.8,
                  image: avatarSource,
                  label: 'User Avatar',
                  padding: Styles.edgeInsetAll5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey1,
                    border: isSvg ? Border.all(color: AppColors.primary, width: 2) : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _goToBuddyPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => BuddyPage(itemId: id));
    await Navigator.push(context, route);
    await route.completed;
  }
}

class _DividerColumn extends StatelessWidget {
  const _DividerColumn({
    required this.title,
    required this.length,
  });

  final String title;
  final int length;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          title,
          style: textTheme.bodySmall,
        ),
        Text(
          '$length',
          style: textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
