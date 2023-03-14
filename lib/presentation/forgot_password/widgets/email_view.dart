import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/app_constants.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/injection.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:buddy/presentation/shared/forms/form_field_with_header.dart';
import 'package:buddy/presentation/shared/padded_text.dart';
import 'package:buddy/presentation/shared/utils/toast_utils.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailView extends StatefulWidget {
  const EmailView({Key? key}) : super(key: key);

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController emailController = TextEditingController();
  late ForgotPasswordBloc _bloc;
  bool submitted = false;

  String? emailError;

  @override
  void didChangeDependencies() {
    _bloc = Injection.forgotPasswordBloc;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ForgotPasswordBloc, ResultState>(
      bloc: _bloc,
      listener: handleListener,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          PaddedText(
            'A link to reset your password will be sent to your email.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormFieldWithHeader(
                  headerText: 'Email Address',
                  hintText: 'Enter your email',
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
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
                PrimaryButton(
                  padding: Styles.authButtonPadding,
                  text: 'Continue',
                  hasLoading: _bloc.isLoading,
                  onPressed: () => _requestCode(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _requestCode(BuildContext context) async {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _bloc.add(ForgotPasswordEvent.sendResetEmail(email: emailController.text));
    }
  }

  void handleListener(BuildContext context, ResultState<dynamic> event) {
    final fToast = ToastUtils.of(context);
    event.whenOrNull(
      refresh: () => _refresh(),
      data: (_) {
        ToastUtils.showSucceedToast(fToast, 'Reset link sent via email');
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
