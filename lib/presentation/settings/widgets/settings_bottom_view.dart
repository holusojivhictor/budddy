import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/presentation/settings/widgets/app_settings_card.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:buddy/presentation/shared/dialogs/secondary_dialog.dart';
import 'package:buddy/presentation/shared/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBottomView extends StatelessWidget {
  const SettingsBottomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSettingsCard(),
        LogoutButton(
          onPressed: () => logOut(context),
        ),
      ],
    );
  }

  void logOut(BuildContext context) {
    final fToast = ToastUtils.of(context);
    showDialog(
      context: context,
      builder: (ctx) => SecondaryDialog(
        titleText: 'Log Out?',
        contentText: 'Are you sure you want to log out?',
        cancelText: 'No, Go back',
        actionText: 'Yes, Log out',
        actionOnPressed: () {
          Navigator.of(context).pop();
          ToastUtils.showInfoToast(fToast, 'Logging user out...');
          context.read<SessionBloc>().add(const SessionEvent.onLogout());
        },
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      isPrimary: false,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.logout_rounded,
            color: AppColors.error,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            'Logout',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
