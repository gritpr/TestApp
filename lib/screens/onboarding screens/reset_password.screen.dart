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

  void showScuccesDialog() async {
    Get.dialog(
      Material(
        type: MaterialType.transparency,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.successBg),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Image.asset(
                    AppAssets.successBg,
                  ),
                ),
                verticalSpace(height: 24),
                Container(
                  padding: pad(horiz: 24),
                  color: AppColors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      text('Success!', weight: FontWeight.w900, size: 15),
                      verticalSpace(height: 4),
                      text(
                          'Your password has been reset successfully.\nKindly sign in with your  new credentials',
                          color: AppColors.cA1A1A1,
                          textAlign: TextAlign.center),
                      verticalSpace(height: 32),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    pop();
                    await pushScreen(const SignInScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    height: eqH(43),
                    color: AppColors.cEEEEEE,
                    child: Center(
                        child: text('Ok',
                            color: AppColors.brandBlue,
                            weight: FontWeight.w700)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
