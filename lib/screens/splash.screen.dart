import 'package:flutter/material.dart';

import '../../__lib.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoNext();
  }

  void gotoNext() async {
    await Future.delayed(const Duration(seconds: 4));
    replaceScreen(const SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: assetsImage(
              AppAssets.logo,
              height: eqH(109),
              width: eqW(118),
            ),
          ),
          Positioned(
              child: Column(
            children: const [],
          ))
        ],
      ),
    );
  }
}
