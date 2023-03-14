import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/injection.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:buddy/presentation/shared/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class OTPInput extends StatefulWidget {
  const OTPInput({Key? key}) : super(key: key);

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SignUpBloc _bloc;
  String code = '';

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
    return BlocListener<SignUpBloc, ResultState>(
      bloc: _bloc,
      listener: handleListener,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Pinput(
              obscureText: true,
              closeKeyboardWhenCompleted: true,
              useNativeKeyboard: true,
              toolbarEnabled: true,
              length: 6,
              onChanged: (v) => code = v,
              androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.grey4,
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: 'Verify',
              hasLoading: _bloc.isLoading,
              onPressed: () => _verifyUser(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyUser(BuildContext context) async {
    final fToast = ToastUtils.of(context);
    if (code.isEmpty) {
      ToastUtils.showErrorToast(fToast, 'Please enter the sent OTP');
      return;
    }

    if (code.length < 6) {
      ToastUtils.showErrorToast(fToast, 'Enter the correct OTP');
      return;
    }

    _bloc.add(SignUpEvent.verifyUser(code: code));
  }

  void handleListener(BuildContext context, ResultState<dynamic> event) {
    final fToast = ToastUtils.of(context);
    event.whenOrNull(
      refresh: () => _refresh(),
      data: (_) {
        ToastUtils.showSucceedToast(fToast, 'Registration successful');
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
