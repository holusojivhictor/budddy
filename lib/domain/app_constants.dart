import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:flutter/material.dart';

const double kPadding = 10.0;
const Duration kAnimationDuration = Duration(milliseconds: 300);
const Curve kCurve = Curves.easeInOut;
const double splashLogoDimension = 195.0;

/// Languages map
const languagesMap = {
  AppLanguageType.english: LanguageModel('en', 'US'),
};

/// Validator strings
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneNumberValidatorRegExp = RegExp(r"^\+[0-9]+$");
final RegExp amountValidatorRegExp = RegExp(r"^[0-9]+$");
const String kEmailNullError = "Please enter your email address.";
const String kNameNullError = "Display name cannot be empty.";
const String kFullNameNullError = "Please enter your full name.";
const String kOccupationNullError = "Please enter your current occupation.";
const String kNameOfChurchNullError = "Please enter your place of worship";
const String cityNullError = "Please enter your city of residence";
const String kFirstNameNullError = "Please enter your first name.";
const String kAddressNullError = "Please enter your address.";
const String kLastNameNullError = "Please enter your last name.";
const String kPhoneNumberNullError = "Please enter your mobile number.";
const String kShortPhoneNumberError = "Phone number must have at least 10 digits.";
const String kInvalidPhoneNumberError = "Please enter a valid mobile number. Incl. country code and plus sign.";
const String kInvalidEmailError = "Please enter a valid email address";
const String kPassNullError = "Please enter your password.";
const String kNewPassNullError = "Please enter your new password.";
const String kPassMatchNullError = "Password does not match.";
const String kShortPassError = "Your password should be at least 8 characters.";
const String kConfirmPassNullError = "Please confirm your password.";

/// Transition to page
Future<void> goToPage(BuildContext context, Widget page) async {
  final route = MaterialPageRoute(builder: (c) => page);
  await Navigator.push(context, route);
}

/// Animated switcher's fade transition
FadeTransition handleFadeTransition(Widget child, Animation<double> animation) {
  final List<TweenSequenceItem<double>> fastOutExtraSlowInTweenSequenceItems =
  <TweenSequenceItem<double>>[
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0.0, end: 0.4).chain(CurveTween(curve: const Cubic(0.05, 0.0, 0.133333, 0.06))),
      weight: 0.166666,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0.4, end: 1.0).chain(CurveTween(curve: const Cubic(0.208333, 0.82, 0.25, 1.0))),
      weight: 1.0 - 0.166666,
    ),
  ];

  final TweenSequence<double> scaleCurveSequence = TweenSequence<double>(fastOutExtraSlowInTweenSequenceItems);

  final Animatable<double> fadeInTransition = Tween<double>(
    begin: 0.0,
    end: 1.00,
  ).chain(CurveTween(curve: const Interval(0.125, 0.250)));

  final Animatable<double> scaleUpTransition = Tween<double>(
    begin: 0.85,
    end: 1.00,
  ).chain(scaleCurveSequence);

  final Animation<double> fadeTransition = fadeInTransition.animate(animation);

  final Animation<double> scaleTransition = scaleUpTransition.animate(animation);

  return FadeTransition(
    opacity: fadeTransition,
    child: ScaleTransition(scale: scaleTransition, child: child),
  );
}
