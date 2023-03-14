import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
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

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SignInBloc _bloc;
  bool obscure = true;
  bool submitted = false;

  String? emailError;
  String? passwordError;

  @override
  void didChangeDependencies() {
    _bloc = Injection.getSignInBloc(context.read<SessionBloc>());
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
    return BlocListener<SignInBloc, ResultState>(
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
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextButton(
                  onPressed: () {
                    context.read<SessionBloc>().add(const SessionEvent.onForgotPassword());
                  },
                  child: Text(
                    'Forgot password',
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            PrimaryButton(
              padding: Styles.authButtonPadding,
              text: 'Login',
              hasLoading: _bloc.isLoading,
              onPressed: () => _signIn(context),
            ),
            Visibility(
              visible: false,
              child: Column(
                children: [
                  const ButtonDivider(
                    dividerText: 'Or Login With',
                  ),
                  GoogleButton(
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _bloc.add(SignInEvent.authenticate(
        email: emailController.text,
        password: passwordController.text,
      ));
    }
  }

  void handleListener(BuildContext context, ResultState<dynamic> event) {
    final fToast = ToastUtils.of(context);
    event.whenOrNull(
      refresh: () => _refresh(),
      data: (_) {
        ToastUtils.showSucceedToast(fToast, 'Log in successful');
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
