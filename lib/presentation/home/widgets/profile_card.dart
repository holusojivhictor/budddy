import 'package:buddy/application/bloc.dart';
import 'package:buddy/presentation/home/widgets/info_card.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) => Row(
          children: [
            Expanded(
              flex: 50,
              child: InfoCard(
                image: state.avatarSource,
                name: state.displayName,
                phone: state.phoneNumber,
              ),
            ),
            Expanded(
              flex: 50,
              child: Column(),
            ),
          ],
        ),
      ),
    );
  }
}
