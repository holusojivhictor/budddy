import 'package:buddy/domain/app_constants.dart';
import 'package:buddy/domain/assets.dart';
import 'package:buddy/theme.dart';
import 'package:flutter/material.dart';

class AnimatedSplash extends StatelessWidget {
  const AnimatedSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeExtension = theme.extension<AppThemeExtension>()!;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'ⓒ 2023 Morpheus',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
              ],
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: splashLogoDimension,
                    height: splashLogoDimension,
                    child: Image.asset(Assets.getGifPath('loading.gif')),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Budddy',
                    style: theme.textTheme.headlineMedium!.copyWith(
                      color: themeExtension.baseTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 34,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
