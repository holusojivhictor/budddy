import 'package:buddy/presentation/shared/custom_app_bar.dart';
import 'package:buddy/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:flutter/material.dart';

class ConnectionsPage extends StatelessWidget {
  const ConnectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverScaffoldWithFab(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppBar(
            title: 'Connections',
            automaticallyImplyLeading: false,
          ),
        ),
      ],
    );
  }
}
