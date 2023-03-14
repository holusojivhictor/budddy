import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/presentation/home/home_page.dart';
import 'package:buddy/presentation/settings/settings_page.dart';
import 'package:buddy/presentation/shared/extensions/focus_scope_node_extensions.dart';
import 'package:buddy/presentation/shared/navigation_bar/animated_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'shared/navigation_bar/navigation_bar_item.dart';

class MobileScaffold extends StatefulWidget {
  final int defaultIndex;
  final TabController tabController;

  const MobileScaffold({
    Key? key,
    required this.defaultIndex,
    required this.tabController,
  }) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.defaultIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MainTabBloc, MainTabState>(
        listener: (ctx, state) async {
          state.maybeMap(
            initial: (s) => _changeCurrentTab(s.currentSelectedTab),
            orElse: () => {},
          );
        },
        child: TabBarView(
          controller: widget.tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const HomePage(),
            Container(),
            Container(),
            const SettingsPage(),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNavigationBar(
        elevation: 0,
        currentIndex: _index,
        selectedItemColor: AppColors.variantBlack,
        unselectedItemColor: AppColors.variantGrey4,
        backgroundColor: AppColors.primary.withOpacity(0.2),
        onItemSelected: _goToTab,
        items: const [
          NavigationBarItem(
            icon: Icon(Icons.face_outlined),
            activeIcon: Icon(Icons.face),
            title: 'Profile',
          ),
          NavigationBarItem(
            icon: Icon(Icons.diversity_2_outlined),
            activeIcon: Icon(Icons.diversity_2_rounded),
            title: 'Buddies',
          ),
          NavigationBarItem(
            icon: Icon(Icons.travel_explore_outlined),
            activeIcon: Icon(Icons.travel_explore_rounded),
            title: 'Discover',
          ),
          NavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            title: 'Settings',
          ),
        ],
      ),
    );
  }

  void _changeCurrentTab(int index) {
    FocusScope.of(context).removeFocus();
    widget.tabController.index = index;
    setState(() {
      _index = index;
    });
  }

  void _goToTab(int newIndex) => context.read<MainTabBloc>().add(MainTabEvent.goToTab(index: newIndex));
}

