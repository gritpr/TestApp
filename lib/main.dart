// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


import '__lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!BuildConfig.isDev) {
    ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue,
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  AppTrackingPermissionHandler.requestTrackingPermisssion();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (val) {
      runApp(
        const ProviderScope(
          child: MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: BuildConfig.isDev,
      title: AppInfo.appTitle,
      theme: ThemeData(
        primarySwatch: AppInfo.appPrimarySwatch,
        textTheme: AppInfo.appTextTheme,
      ),
      home: const SplashScreen(),
    );
  }
}
