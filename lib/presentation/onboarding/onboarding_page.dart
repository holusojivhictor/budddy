import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/domain/assets.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryShade,
              theme.colorScheme.onPrimaryContainer,
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 20,
              child: SizedBox(
                width: size.width,
                child: Image.asset(
                  Assets.getImagePath('group.png'),
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text.rich(
                    TextSpan(
                      text: "Let's Get\n",
                      style: theme.textTheme.headlineLarge!.copyWith(
                        height: 1.6,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Started',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Connect and network with sports enthusiasts around the world. Meet and create new budddies!',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  text: 'Join Now',
                  backgroundColor: AppColors.white,
                  textColor: theme.colorScheme.primary,
                  onPressed: () => navigateTo(context, const SessionEvent.onSignUp()),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Already have an account?',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => navigateTo(context, const SessionEvent.onSignIn()),
                      child: Text(
                        'Login',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void navigateTo(BuildContext context, SessionEvent event) {
    context.read<SessionBloc>().add(event);
  }
}
