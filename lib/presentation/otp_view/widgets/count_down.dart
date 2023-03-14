import 'package:buddy/colors.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';

class CountDownWidget extends StatelessWidget {
  const CountDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: Styles.edgeInsetAll7,
      decoration: BoxDecoration(
        color: const Color(0xFFFDEDED),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const CountDownAnimation(),
    );
  }
}

class CountDownAnimation extends StatelessWidget {
  const CountDownAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TweenAnimationBuilder(
      tween: IntTween(begin: 180, end: 0),
      duration: const Duration(minutes: 3),
      builder: (context, value, child) => Text(
        _duration(parse(value)),
        style: theme.textTheme.bodyLarge!.copyWith(color: AppColors.error),
      ),
    );
  }

  Duration parse(int value) {
    return Duration(seconds: value);
  }

  String _duration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
