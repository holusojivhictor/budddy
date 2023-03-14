import 'package:buddy/presentation/update_password/widgets/update_password_form.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'Update Password',
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: const SafeArea(
        child: UpdatePasswordForm(),
      ),
    );
  }
}
