import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mhub/data/models/create_account_response.dart';

import '../../__lib.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  AuthRemoteRepo authRemoteRepo = AuthRemoteRepoImp();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  String number = '';

  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  bool isLoading = false;

  onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    updateIsLoading();
    final result = await authRemoteRepo.createAccount(
      email: emailController.text.toLowerCase(),
      fullName: fullNameController.text,
      password: passwordController.text,
    );
    updateIsLoading();
    if (result is ErrorResponse) {
      showErrorSnackbar('Something went Wrong, try Again');
    } else {
      result as CreateAccountResponse;
      context.read(authViewModel).setUserProfile(user: result.data);

      pushScreen(VerifyEmailScreen(
        password: passwordController.text,
        email: emailController.text.toLowerCase(),
        otp: result.data!.otp!.trim(),
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            col(
              children: [
                verticalSpace(height: 27),
                IconButton(
                    icon: Image.asset(AppAssets.backButton),
                    onPressed: () {
                      pop();
                    }),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: pad(horiz: 16.0),
                      child: col(
                        children: [
                          verticalSpace(height: 32),
                          text('Create an Account',
                              size: 21, weight: FontWeight.w900),
                          verticalSpace(height: 4),

                          verticalSpace(height: 32),

                          verticalSpace(height: 4),
                          Form(
                            key: _formKey,
                            child: col(
                              children: [
                                inputFeild(
                                  label: 'Full Name',
                                  controller: fullNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your first name';
                                    }
                                    return null;
                                  },
                                ),
                                verticalSpace(),
                                inputFeild(
                                  label: 'Email Address',
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
                                verticalSpace(),
                                passwordFeild(
                                  controller: passwordController,
                                  onToggleVisibility: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  showPassword: showPassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please a unique password';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          verticalSpace(height: 64),
                          // const Spacer(),
                          wideButton(onPressed: onSubmit, label: 'Next'),
                          verticalSpace(),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                replaceScreen(
                                  const SignInScreen(),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.lato(
                                      color: AppColors.cA1A1A1, fontSize: 11),
                                  children: [
                                    const TextSpan(
                                        text: 'Already Registered? '),
                                    TextSpan(
                                      text: 'Sign in',
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
                    ),
                  ),
                ),
              ],
            ),
            if (isLoading) loaderScreen(),
          ],
        ),
      ),
    );
  }
}
