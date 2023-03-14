import 'package:buddy/application/bloc.dart';
import 'package:buddy/presentation/forgot_password/widgets/email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: SafeArea(
        child: EmailView(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      leading: InkWell(
        onTap: () => handleWillPop(context),
        borderRadius: BorderRadius.circular(30),
        child: const Icon(Icons.arrow_back_sharp, color: Color(0xFF231F20)),
      ),
      title: Text(
        'Reset Password',
        textAlign: TextAlign.center,
        style: theme.textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }

  void handleWillPop(BuildContext context) async {
    context.read<SessionBloc>().add(const SessionEvent.onSignIn());
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
