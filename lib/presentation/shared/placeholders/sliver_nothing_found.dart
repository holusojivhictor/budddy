import 'package:flutter/material.dart';

import 'nothing_found_column.dart';

class SliverNothingFound extends StatelessWidget {
  final String? msg;
  final EdgeInsets padding;
  const SliverNothingFound({
    Key? key,
    this.msg,
    this.padding = const EdgeInsets.all(20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: NothingFoundColumn(msg: msg),
    );
  }
}
