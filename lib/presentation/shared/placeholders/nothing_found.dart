import 'package:flutter/material.dart';

class NothingFound extends StatelessWidget {
  final String? msg;
  final IconData icon;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  const NothingFound({
    Key? key,
    this.msg,
    this.icon = Icons.info,
    this.textStyle,
    this.padding = const EdgeInsets.all(20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              msg ?? 'Nothing to show',
              textAlign: TextAlign.center,
              style: textStyle ?? theme.textTheme.titleLarge!.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
