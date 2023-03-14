import 'package:buddy/application/bloc.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/body_bottom_view.dart';
import 'widgets/body_top_view.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'Update Profile',
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (ctx, state) => state.map(
          loading: (_) => const Loading(useScaffold: false),
          loaded: (state) => SafeArea(
            child: Column(
              children: [
                BodyTopView(
                  displayName: state.displayName,
                  avatarSource: state.avatarSource,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: BodyBottomView(
                      emailAddress: state.emailAddress,
                      phoneNumber: state.phoneNumber,
                      displayName: state.displayName,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
