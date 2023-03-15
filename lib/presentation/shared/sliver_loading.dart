import 'package:flutter/material.dart';

import 'loading.dart';

class SliverLoading extends StatelessWidget {
  const SliverLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(hasScrollBody: false, child: Loading(useScaffold: false));
  }
}
