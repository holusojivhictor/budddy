import 'dart:async';

import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/presentation/home/widgets/avatar_list_view.dart';
import 'package:buddy/presentation/home/widgets/home_header.dart';
import 'package:buddy/presentation/shared/bordered_info_container.dart';
import 'package:buddy/presentation/shared/utils/modal_bottom_sheet_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  late HomeBloc _bloc;
  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<HomeBloc>();
    if (!_bloc.hasInterests) {
      Timer(const Duration(milliseconds: 200), () {
        if (mounted) ModalBottomSheetUtils.showAppModalBottomSheet(context, EndDrawerItemType.interests);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ResponsiveBuilder(
      builder: (ctx, size) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              HomeHeader(
                onTap: () => _goToTab(3),
              ),
              const AvatarListView(),
              const BorderedInfoContainer(
                title: 'Discover and connect with friends of shared interests from all over the globe.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToTab(int newIndex) => context.read<MainTabBloc>().add(MainTabEvent.goToTab(index: newIndex));
}
