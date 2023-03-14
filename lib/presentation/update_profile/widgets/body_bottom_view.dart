import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/domain/app_constants.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:buddy/presentation/shared/forms/form_field_with_header.dart';
import 'package:buddy/presentation/shared/utils/toast_utils.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:buddy/presentation/update_password/update_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyBottomView extends StatefulWidget {
  final String emailAddress;
  final String phoneNumber;
  final String displayName;

  const BodyBottomView({
    Key? key,
    required this.emailAddress,
    required this.phoneNumber,
    required this.displayName,
  }) : super(key: key);

  @override
  State<BodyBottomView> createState() => _BodyBottomViewState();
}

class _BodyBottomViewState extends State<BodyBottomView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  late HomeBloc _bloc;
  bool changed = false;
  bool submitted = false;

  String? nameError;

  @override
  void didChangeDependencies() {
    emailController.text = widget.emailAddress;
    phoneController.text = widget.phoneNumber;
    displayNameController.text = widget.displayName;
    _bloc = context.read<HomeBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormFieldWithHeader(
            enabled: false,
            controller: emailController,
            textInputType: TextInputType.emailAddress,
            headerText: 'Email Address',
            hintText: 'Not modifiable',
          ),
          FormFieldWithHeader(
            enabled: false,
            controller: phoneController,
            textInputType: TextInputType.phone,
            headerText: 'Phone Number',
            hintText: 'Not modifiable',
          ),
          FormFieldWithHeader(
            controller: displayNameController,
            textInputType: TextInputType.name,
            headerText: 'Display Name',
            hintText: 'Enter your display name',
            autoValidate: submitted,
            errorText: nameError,
            onChanged: (_) => setState(() => changed = true),
            validator: (value) {
              if (value!.isEmpty) {
                return kNameNullError;
              }
              return null;
            },
          ),
          PrimaryButton(
            padding: Styles.authButtonPadding,
            text: 'Submit',
            enabled: changed,
            hasLoading: _bloc.isLoading,
            onPressed: () async {
              await _handleProfileUpdate().then((_) {
                setState(() => changed = false);
                _showSuccessToast();
              });
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                borderRadius: 24,
                backgroundColor: AppColors.secondary,
                contentPadding: Styles.edgeInsetHorizontal10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Change your password',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey7,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.tertiary.withOpacity(0.5),
                      child: const Icon(Icons.keyboard_arrow_right, size: 20, color: AppColors.grey7),
                    ),
                  ],
                ),
                onPressed: () => _goToChangePassword(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _handleProfileUpdate() async {
    setState(() => submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _refresh();
      await _bloc.updateUserProfile(
        email: emailController.text,
        displayName: displayNameController.text,
      );
    }
  }

  void _refresh() {
    setState(() {});
  }

  void _showSuccessToast() {
    final fToast = ToastUtils.of(context);
    ToastUtils.showSucceedToast(fToast, 'Profile successfully updated');
  }

  Future<void> _goToChangePassword(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => const UpdatePasswordPage());
    await Navigator.push(context, route);
  }
}
