import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/assets.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/injection.dart';
import 'package:buddy/presentation/shared/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'primary_button.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  late GoogleSignInBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Injection.getGoogleSignInBloc(context.read<SessionBloc>());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<GoogleSignInBloc, ResultState>(
      bloc: _bloc,
      listener: handleListener,
      child: PrimaryButton(
        isPrimary: false,
        onPressed: signInWithGoogle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.getImagePath('google_icon.png'), height: 16),
            const SizedBox(width: 5),
            Text(
              'Google',
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    _bloc.add(const GoogleSignInEvent.authenticate());
  }

  void handleListener(BuildContext context, ResultState<dynamic> event) {
    final fToast = ToastUtils.of(context);
    event.whenOrNull(
      data: (_) {
        ToastUtils.showSucceedToast(fToast, 'Sign in successful');
        return null;
      },
      error: (e) {
        _refresh();
        ToastUtils.showErrorToast(fToast, NetworkExceptions.getErrorMessage(e));
        return null;
      },
    );
  }

  void _refresh() {
    setState(() {});
  }
}
