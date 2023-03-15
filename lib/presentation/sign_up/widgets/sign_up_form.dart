import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/app_constants.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/injection.dart';
import 'package:buddy/presentation/shared/button_divider.dart';
import 'package:buddy/presentation/shared/buttons/google_button.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:buddy/presentation/shared/forms/form_field_with_header.dart';
import 'package:buddy/presentation/shared/utils/toast_utils.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  late SignUpBloc _bloc;
  bool obscure = true;
  bool submitted = false;

  String? emailError;
  String? phoneError;
  String? passwordError;
  String? confirmPasswordError;

  @override
  void didChangeDependencies() {
    _bloc = Injection.getSignUpBloc(context.read<SessionBloc>());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<SignUpBloc, ResultState>(
      bloc: _bloc,
      listener: handleListener,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormFieldWithHeader(
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              headerText: 'Email Address',
              hintText: 'Enter your email',
              autoValidate: submitted,
              errorText: emailError,
              validator: (value) {
                if (value!.isEmpty) {
                  return kEmailNullError;
                } else if (!emailValidatorRegExp.hasMatch(value)) {
                  return kInvalidEmailError;
                }
                return null;
              },
            ),
            FormFieldWithHeader(
              controller: phoneController,
              textInputType: TextInputType.phone,
              headerText: 'Mobile Number',
              hintText: 'Enter your mobile number',
              autoValidate: submitted,
              errorText: phoneError,
              validator: (value) {
                if (value!.isEmpty) {
                  return kPhoneNumberNullError;
                } else if (!phoneNumberValidatorRegExp.hasMatch(value)) {
                  return kInvalidPhoneNumberError;
                }
                return null;
              },
            ),
            FormFieldWithHeader(
              controller: passwordController,
              textInputType: TextInputType.text,
              headerText: 'Password',
              hintText: 'Enter your password',
              autoValidate: submitted,
              obscure: obscure,
              trailing: GestureDetector(
                onTap: () => setState(() => obscure = !obscure),
                child: Text(
                  obscure ? 'Show' : 'Hide',
                  style: textTheme.bodyLarge!.copyWith(fontSize: 15),
                ),
              ),
              errorText: passwordError,
              validator: (value) {
                if (value!.isEmpty) {
                  return kPassNullError;
                } else if (value.length < 8) {
                  return kShortPassError;
                }
                return null;
              },
            ),
            FormFieldWithHeader(
              controller: confirmPasswordController,
              textInputType: TextInputType.text,
              headerText: 'Confirm Password',
              hintText: 'Confirm your password',
              autoValidate: submitted,
              obscure: obscure,
              errorText: confirmPasswordError,
              validator: (value) {
                if (value!.isEmpty) {
                  return kPassNullError;
                } else if (value != passwordController.text) {
                  return kPassMatchNullError;
                }
                return null;
              },
            ),
            PrimaryButton(
              padding: Styles.authButtonPadding,
              text: 'Sign Up',
              hasLoading: _bloc.isLoading,
              onPressed: () => _signUp(context),
            ),
            Column(
              children: const [
                ButtonDivider(
                  dividerText: 'Or Sign Up With',
                ),
                GoogleButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _bloc.add(SignUpEvent.register(
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      ));
    }
  }

  void handleListener(BuildContext context, ResultState<dynamic> event) {
    final fToast = ToastUtils.of(context);
    event.whenOrNull(
      refresh: () => _refresh(),
      data: (_) {
        ToastUtils.showSucceedToast(fToast, 'Created new user');
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


