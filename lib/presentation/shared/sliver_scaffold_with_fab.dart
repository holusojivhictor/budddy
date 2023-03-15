import 'package:flutter/material.dart';

import 'extensions/focus_scope_node_extensions.dart';
import 'mixins/app_fab_mixin.dart';

class SliverScaffoldWithFab extends StatefulWidget {
  final List<Widget> slivers;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final ScrollPhysics? physics;

  const SliverScaffoldWithFab({
    Key? key,
    required this.slivers,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.physics,
  }) : super(key: key);

  @override
  State<SliverScaffoldWithFab> createState() => _SliverScaffoldWithFabState();
}

class _SliverScaffoldWithFabState extends State<SliverScaffoldWithFab> with SingleTickerProviderStateMixin, AppFabMixin {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScope.of(context).removeFocus();
      },
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: CustomScrollView(
          physics: widget.physics ?? const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          controller: scrollController,
          slivers: widget.slivers,
        ),
        bottomNavigationBar: widget.bottomNavigationBar,
        floatingActionButton: widget.floatingActionButton ?? getAppFab(),
      ),
    );
  }
}
