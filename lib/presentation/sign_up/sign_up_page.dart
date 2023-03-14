import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/presentation/shared/header_title.dart';
import 'package:buddy/presentation/sign_up/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const HeaderTitle(
                title: 'Create Account',
                subtitle: 'Connect with your pals today!',
              ),
              const SizedBox(height: 20),
              const Flexible(
                child: SingleChildScrollView(
                  child: SignUpForm(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      ),
                    ),
                    TextButton(
                      onPressed: () => navigateTo(context, const SessionEvent.onSignIn()),
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateTo(BuildContext context, SessionEvent event) {
    context.read<SessionBloc>().add(event);
  }
}

