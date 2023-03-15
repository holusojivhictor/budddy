import 'package:buddy/presentation/shared/custom_app_bar.dart';
import 'package:buddy/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:flutter/material.dart';

import 'widgets/buddies_sliver_view.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverScaffoldWithFab(
      physics: ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppBar(
            title: 'Discover',
            automaticallyImplyLeading: false,
          ),
        ),
        BuddiesSliverView(),
      ],
    );
  }
}
