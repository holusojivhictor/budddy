import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/presentation/shared/avatars/avatar_preview.dart';
import 'package:buddy/presentation/shared/circle_icon.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatelessWidget {
  final void Function()? onTap;

  const HomeHeader({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) {
          final isSvg = state.avatarSource.contains('api.dicebear.com');

          return Padding(
            padding: Styles.edgeInsetAll16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Welcome back, \n',
                    style: textTheme.headlineSmall!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: state.displayName,
                        style: textTheme.headlineSmall!.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _SettingsButton(onTap: onTap),
                    const SizedBox(width: 8),
                    AvatarPreview(
                      height: 40,
                      image: state.avatarSource,
                      label: 'User avatar',
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: isSvg ? Border.all(color: AppColors.primary, width: 1.5) : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton({
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: const CircleIcon(
        icon: Icons.settings_outlined,
      ),
    );
  }
}
