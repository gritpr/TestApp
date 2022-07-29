import 'package:flutter/material.dart';

import '../../__lib.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  AuthRemoteRepo authRemoteRepo = AuthRemoteRepoImp();

  TextEditingController emailController = TextEditingController();

  bool showPassword = false;

  bool isLoading = false;

  onSubmit() async {
    updateIsLoading();
    final result = await authRemoteRepo.passwordResetRequest(
        email: emailController.text.toLowerCase());
    updateIsLoading();
    if (result is ErrorResponse) {
      showErrorSnackbar('${result.message}');
    } else {
      result as PasswordResetRequestResponse;
      await pushScreen(ResetPasswordScreen(
        email: emailController.text,
        userId: result.data!.userId ?? '',
      ));
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        verticalSpace(height: 27),
        text('Forgot Password', size: 21, weight: FontWeight.w900),
        verticalSpace(height: 40),
        inputFeild(
          label: 'Email',
          controller: emailController,
          hint: 'space@example.com',
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !value.contains('@') ||
                !value.contains('.com')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        verticalSpace(height: 48),
        wideButton(onPressed: onSubmit, label: 'Reset')
      ]),
    );
  }
}
