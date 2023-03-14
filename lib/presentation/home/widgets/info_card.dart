import 'package:buddy/colors.dart';
import 'package:buddy/presentation/shared/cards/custom_card.dart';
import 'package:buddy/presentation/shared/padded_text.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoCard extends StatelessWidget {
  final String image;
  final String name;
  final String phone;

  const InfoCard({
    Key? key,
    required this.image,
    required this.name,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CustomCard(
      color: AppColors.grey1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Padding(
        padding: Styles.edgeInsetAll10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 70,
              child: SvgPicture.network(
                image,
                semanticsLabel: 'User avatar',
                placeholderBuilder: (ctx) => const CupertinoActivityIndicator(),
              ),
            ),
            const SizedBox(height: 5),
            PaddedText(
              name,
              padding: Styles.edgeInsetHorizontal10,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 5),
            PaddedText(
              phone,
              padding: Styles.edgeInsetHorizontal10,
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
