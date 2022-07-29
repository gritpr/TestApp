import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhub/screens/onboarding%20screens/create_account.dart';

import '../../__lib.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthRemoteRepo authRemoteRepo = AuthRemoteRepoImp();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isButtonActive = true;
  bool showPassword = false;

  bool isLoading = false;

  onSubmit() async {
    updateIsLoading();
    final result = await authRemoteRepo.logIn(
      email: emailController.text,
      password: passwordController.text,
    );
    updateIsLoading();
    log(result);

    if (result is ErrorResponse) {
     
      showErrorSnackbar('${result.message}');
    }
    if (result is LogInResponse) {
      context.read(authViewModel).logIn(
          logIn: result.data!,
          emailAddress: emailController.text,
          password: passwordController.text);
      replaceScreen(const HomeScreen());
    }
  }

  updateIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isLoading: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(height: 27),
          text('Welcome Back', size: 21, weight: FontWeight.w900),
          verticalSpace(height: 4),
          verticalSpace(height: 40),
          inputFeild(
            label: 'Email',
            controller: emailController,
            hint: 'space@example.com',
          ),
          verticalSpace(height: 16),
          passwordFeild(
            controller: passwordController,
            onToggleVisibility: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            showPassword: showPassword,
          ),
          verticalSpace(height: 8),
          InkWell(
              onTap: () async {
                await pushScreen(
                  const ForgotPasswordScreen(),
                );
              },
              child: text('Forgot Password',
                  size: 12, color: AppColors.lightGreen)),
          verticalSpace(height: 68),
          wideButton(
              onPressed: isButtonActive ? onSubmit : null, label: 'Sign in'),
          verticalSpace(),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () async {
                await replaceScreen(
                  const CreateAccountScreen(),
                );
              },
              child: RichText(
                text: TextSpan(
                  style:
                      GoogleFonts.lato(color: AppColors.cA1A1A1, fontSize: 11),
                  children: [
                    const TextSpan(text: "Not registered yet? "),
                    TextSpan(
                      text: 'Sign up',
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
