import 'package:flutter/material.dart';
import 'package:mhub/values/app_assets.dart';
import 'package:mhub/values/app_colors.dart';
import 'package:mhub/widgets/image.dart';

Widget loaderScreen() {
  return Positioned.fill(
      child: Container(
    color: AppColors.c121212.withOpacity(.8),
    child: Center(
      child: SizedBox(
          width: 75,
          height: 54,
          child: assetsImage(AppAssets.logoIcon, fit: BoxFit.fill)),
    ),
  ));
}
