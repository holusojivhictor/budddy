import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/presentation/shared/avatars/avatar_preview.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:buddy/presentation/shared/padded_text.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:buddy/presentation/update_profile/update_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsTopView extends StatelessWidget {
  const SettingsTopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) => Column(
          children: [
            AvatarPreview(
              label: 'Profile picture',
              image: state.avatarSource,
            ),
            PaddedText(
              state.displayName,
              padding: Styles.edgeInsetAll5,
              style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
            PrimaryButton(
              text: 'Update Profile',
              borderRadius: 24,
              padding: Styles.edgeInsetAll5,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              textStyle: textTheme.titleSmall!.copyWith(color: AppColors.white),
              onPressed: () => _goToUpdateProfile(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToUpdateProfile(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => const UpdateProfilePage());
    await Navigator.push(context, route);
  }
}
