import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../__lib.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  final String password;
  final String otp;
  const VerifyEmailScreen(
      {Key? key, required this.email, required this.password, required this.otp})
      : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  AuthRemoteRepo authRemoteRepo = AuthRemoteRepoImp();
  bool isLoading = false;
  TextEditingController codeController = TextEditingController();

  bool isButtonActive = false;

  onSubmit() async {
    updateIsLoading();
    final result = await authRemoteRepo.verifyEmail(
        email: widget.email, otp: widget.otp);
    updateIsLoading();
    if (result is ErrorResponse) {
      showErrorSnackbar('${result.message}');
    } else {
      //After Email is verified, log user in
      result as VerifyEmailResponse;
      context.read(authViewModel).setUserProfile(user: result.data);
      final loginResult = await authRemoteRepo.logIn(
          email: widget.email, password: widget.password);
      if (loginResult is ErrorResponse) {
        showErrorSnackbar('${result.message}');
      } else {
        loginResult as LogInResponse;
        context.read(authViewModel).setToken(loginResult.data!.token);
        replaceScreen(const HomeScreen());
      }
    }
  }

  getNewCode() async {
    // updateIsLoading();
    // final result = await authRemoteRepo.initiateEmailVerification();
    // updateIsLoading();
    // if (result is ErrorResponse) {
    //   showErrorSnackbar('${result.error}');
    // } else {
    //   showSuccessSnackbar('Email resent!');
    // }
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
          verticalSpace(height: 27),
          text('Verify Your Email Address', size: 21, weight: FontWeight.w900),
          verticalSpace(height: 4),
          text('Please enter the code sent  to ${widget.email}',
              size: 13, color: AppColors.cA1A1A1, softWrap: true),
          verticalSpace(height: 32),
          inputFeild(
              label: 'Verification Code',
              controller: codeController,
              hint: '000-000',
              onChanged: (c) {
                setState(
                  () {
                    if (codeController.text.length < 4) {
                      isButtonActive = false;
                      return;
                    }
                    isButtonActive = true;
                  },
                );
              }),
          // const Spacer(),
          verticalSpace(height: 64),
          wideButton(
              onPressed: isButtonActive ? onSubmit : null, label: 'Next'),
          verticalSpace(),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: getNewCode,
              child: RichText(
                text: TextSpan(
                  style:
                      GoogleFonts.lato(color: AppColors.cA1A1A1, fontSize: 11),
                  children: [
                    const TextSpan(text: "Didn't recieve a code? "),
                    TextSpan(
                      text: 'Resend',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          verticalSpace(height: 34),
        ],
      ),
    );
  }
}
