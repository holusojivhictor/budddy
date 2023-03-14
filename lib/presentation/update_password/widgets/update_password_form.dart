import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/app_constants.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/injection.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:buddy/presentation/shared/forms/custom_form_field.dart';
import 'package:buddy/presentation/shared/utils/toast_utils.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordForm extends StatefulWidget {
  const UpdatePasswordForm({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordForm> createState() => _UpdatePasswordFormState();
}

class _UpdatePasswordFormState extends State<UpdatePasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController currentPasswordController = TextEditingController();
  late TextEditingController newPasswordController = TextEditingController();
  late TextEditingController confirmPasswordController = TextEditingController();
  late SignInBloc _bloc;
  bool submitted = false;

  String? currentPasswordErrorText;
  String? newPasswordErrorText;
  String? confirmPasswordErrorText;

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
    return BlocListener<SignInBloc, ResultState>(
      bloc: _bloc,
      listener: handleListener,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomFormField(
              hintText: 'Current password',
              textEditingController: currentPasswordController,
              textInputType: TextInputType.text,
              errorText: currentPasswordErrorText,
              onChanged: (_) => setState(() {}),
              autoValidate: submitted,
              hasMargin: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return kPassNullError;
                } else if (value.length < 8) {
                  return kShortPassError;
                }
                return null;
              },
            ),
            CustomFormField(
              hintText: 'New password',
              textEditingController: newPasswordController,
              textInputType: TextInputType.text,
              errorText: newPasswordErrorText,
              onChanged: (_) => setState(() {}),
              autoValidate: submitted,
              hasMargin: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return kNewPassNullError;
                } else if (value.length < 8) {
                  return kShortPassError;
                }
                return null;
              },
            ),
            CustomFormField(
              hintText: 'Confirm new password',
              textEditingController: confirmPasswordController,
              textInputType: TextInputType.text,
              errorText: confirmPasswordErrorText,
              onChanged: (_) => setState(() {}),
              autoValidate: submitted,
              hasMargin: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return kConfirmPassNullError;
                } else if (value != newPasswordController.text) {
                  return kPassMatchNullError;
                }
                return null;
              },
            ),
            PrimaryButton(
              padding: Styles.authButtonPadding,
              text: 'Save changes',
              hasLoading: _bloc.isLoading,
              onPressed: () => _handleUpdatePassword(context),
            ),
          ],
        ),
      ),
    );
  }

  void _handleUpdatePassword(BuildContext context) {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _bloc.add(SignInEvent.updatePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
      ));
    }
  }

  void handleListener(BuildContext context, ResultState<dynamic> event) {
    final fToast = ToastUtils.of(context);
    event.whenOrNull(
      refresh: () => _refresh(),
      data: (_) {
        _clear();
        ToastUtils.showSucceedToast(fToast, 'Password updated successfully');
        return null;
      },
      error: (e) {
        _refresh();
        ToastUtils.showErrorToast(fToast, NetworkExceptions.getErrorMessage(e));
        return null;
      },
    );
  }

  void _clear() {
    setState(() => submitted = false);
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  void _refresh() {
    setState(() {});
  }
}
