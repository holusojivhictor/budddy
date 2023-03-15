import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/presentation/discover/widgets/buddy_card.dart';
import 'package:buddy/presentation/shared/placeholders/sliver_nothing_found.dart';
import 'package:buddy/presentation/shared/sliver_loading.dart';
import 'package:buddy/presentation/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class BuddiesSliverView extends StatelessWidget {
  const BuddiesSliverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuddiesBloc, BuddiesState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const SliverLoading(),
        loaded: (state) => state.data.isNotEmpty
            ? _buildGrid(context, state.data)
            : const SliverNothingFound(msg: 'No buddy found'),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<BuddyCardModel> buddies) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      sliver: SliverWaterfallFlow(
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context),
          crossAxisSpacing: isPortrait ? 15 : 10,
          mainAxisSpacing: 15,
        ),
        delegate: SliverChildBuilderDelegate((context, index) => BuddyCard.item(buddy: buddies[index]),
          childCount: buddies.length,
        ),
      ),
    );
  }
}
