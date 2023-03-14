import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/presentation/home/widgets/avatar_list_preview.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarListView extends StatelessWidget {
  const AvatarListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) {
          List<AvatarCardModel> avatarList = state.friends.map((e) {
            return AvatarCardModel(displayName: e.displayName, avatarSource: e.avatarSource);
          }).toList();

          final user = AvatarCardModel(displayName: 'Me', avatarSource: state.avatarSource, isUser: true);
          final newList = [user] + avatarList;
          return SizedBox(
            height: 80,
            child: ListView.builder(
              padding: Styles.edgeInsetHorizontal16,
              scrollDirection: Axis.horizontal,
              itemCount: newList.length,
              itemBuilder: (ctx, index) => AvatarListPreview.item(model: newList[index]),
            ),
          );
        },
      ),
    );
  }
}
