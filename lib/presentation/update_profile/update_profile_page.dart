import 'package:buddy/application/bloc.dart';
import 'package:buddy/presentation/shared/custom_app_bar.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/body_bottom_view.dart';
import 'widgets/body_top_view.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Update Profile'),
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

