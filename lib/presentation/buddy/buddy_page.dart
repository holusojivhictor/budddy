import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/injection.dart';
import 'package:buddy/presentation/buddy/widgets/bottom_sheet.dart';
import 'package:buddy/presentation/shared/avatars/avatar_preview.dart';
import 'package:buddy/presentation/shared/container_tag.dart';
import 'package:buddy/presentation/shared/custom_app_bar.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuddyPage extends StatelessWidget {
  final String itemId;

  const BuddyPage({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => Injection.getBuddyBloc(context.read<HomeBloc>())
        ..add(BuddyEvent.loadFromId(id: itemId)),
      child: const _PortraitLayout(),
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuddyBloc, BuddyState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const CustomAppBar(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _BuddyPageAvatar(
                            displayName: state.displayName,
                            avatarSource: state.avatarSource,
                          ),
                          BlocBuilder<HomeBloc, HomeState>(
                            builder: (ct, homeState) => homeState.map(
                              loading: (_) => const Loading(useScaffold: false),
                              loaded: (homeState) => _BuddyPageAvatar(
                                avatarSource: homeState.avatarSource,
                                displayName: 'You',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: BuddyBottomSheet(
                    id: state.id,
                    isLoading: state.isLoading,
                    displayName: state.displayName,
                    interests: state.interests,
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

class _BuddyPageAvatar extends StatelessWidget {
  const _BuddyPageAvatar({
    required this.avatarSource,
    required this.displayName,
  });

  final String avatarSource;
  final String displayName;

  @override
  Widget build(BuildContext context) {
    final isSvg = avatarSource.contains('api.dicebear.com');
    return Column(
      children: [
        AvatarPreview(
          height: 90,
          image: avatarSource,
          label: 'User Avatar',
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.grey1,
            border: isSvg ? Border.all(color: AppColors.primary, width: 3) : null,
          ),
        ),
        const SizedBox(height: 5),
        ContainerTag(
          tagText: '$displayName👋',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.variantGrey1,
          ),
        ),
      ],
    );
  }
}
