import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/app_constants.dart';
import 'package:buddy/presentation/forgot_password/forgot_password_page.dart';
import 'package:buddy/presentation/main_tab_page.dart';
import 'package:buddy/presentation/onboarding/onboarding_page.dart';
import 'package:buddy/presentation/otp_view/otp_view.dart';
import 'package:buddy/presentation/sign_in/sign_in_page.dart';
import 'package:buddy/presentation/sign_up/sign_up_page.dart';
import 'package:buddy/presentation/splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionWrapper extends StatelessWidget {
  const SessionWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) => AnimatedSwitcher(
        duration: kAnimationDuration,
        transitionBuilder: handleFadeTransition,
        child: state.map(
          unInitialized: (_) => const AnimatedSplash(),
          unAuthenticated: (_) => const OnboardingPage(),
          signUpState: (_) => const SignUpPage(),
          signInState: (_) => const SignInPage(),
          forgotPassword: (_) => const ForgotPasswordPage(),
          otpVerificationState: (_) => const OTPView(),
          authenticated: (_) => const MainTabPage(),
        ),
      ),
    );
  }
}

