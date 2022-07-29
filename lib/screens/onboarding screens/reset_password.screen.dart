import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../__lib.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email, userId;

  const ResetPasswordScreen(
      {Key? key, required this.email, required this.userId})
      : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  AuthRemoteRepo authRemoteRepo = AuthRemoteRepoImp();

  TextEditingController codeController = TextEditingController();

  TextEditingController firstPasswordController = TextEditingController();

  TextEditingController secondPasswordController = TextEditingController();
  bool isLoading = false;

  bool isButtonActive = true;
  bool showPassword = false;

  final _formKey = GlobalKey<FormState>();

  onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    updateIsLoading();

    /// There is currecntly no way of getting the otp.

    final result = await authRemoteRepo.resetPassword(
      userId: widget.userId,
      newPassword: firstPasswordController.text,
      otp: codeController.text,
    );
    updateIsLoading();
    if (result is ErrorResponse) {
      showErrorSnackbar('${result.message}');
    } else {
      showSuccessSnackbar('Password reset successfully, please sign in');
      replaceScreen(const SignInScreen());
    }
  }

  updateIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isLoading: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(height: 32),
          text('Reset Password', size: 21, weight: FontWeight.w900),
          verticalSpace(height: 4),
          text(
              'Please enter the code that was sent to ${widget.email} and input your new password',
              size: 13,
              textAlign: TextAlign.justify,
              color: AppColors.cA1A1A1,
              softWrap: true),
          verticalSpace(height: 40),
          Form(
            key: _formKey,
            child: col(children: [
              inputFeild(
                label: 'Verification Code',
                controller: codeController,
                hint: '000-000',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the code sent to your mail';
                  }
                  return null;
                },
              ),
              verticalSpace(),
              passwordFeild(
                controller: firstPasswordController,
                onToggleVisibility: () {
                  setState(
                    () {
                      showPassword = !showPassword;
                    },
                  );
                },
                showPassword: showPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
              ),
              verticalSpace(),
              passwordFeild(
                controller: secondPasswordController,
                onToggleVisibility: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                showPassword: showPassword,
                validator: (value) {
                  if (value != firstPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ]),
          ),
          verticalSpace(height: 68),
          wideButton(
              onPressed: isButtonActive ? onSubmit : null,
              label: 'Reset Password'),
          verticalSpace(height: 34),
        ],
      ),
    );
  }
}
