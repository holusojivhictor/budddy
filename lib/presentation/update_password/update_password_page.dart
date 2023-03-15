import 'package:buddy/presentation/shared/custom_app_bar.dart';
import 'package:buddy/presentation/update_password/widgets/update_password_form.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Update Password'),
      body: SafeArea(
        child: UpdatePasswordForm(),
      ),
    );
  }
}
