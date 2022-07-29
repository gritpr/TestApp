import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../__lib.dart';

Function get err => () => Get.snackbar('Error Title', 'Failed: Change Theme');

void showErrorSnackbar(String error, {EdgeInsets? margin, Color? color}) {
  showSnackbar(
    error,
    color ?? AppColors.cCD0000,
    Colors.white,
    margin,
  );
}

void showSuccessSnackbar(String message, {EdgeInsets? margin}) {
  showSnackbar(
    message,
    const Color(0xFF00F872),
    Colors.white,
    margin,
  );
}

void showSnackbar(String message, Color backgroundColor,
    [Color textColor = Colors.white, EdgeInsets? margin]) {
  Get.closeAllSnackbars();
  Get.snackbar(
    message,
    '',
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 3),
    icon: Container(),
    messageText: Container(),
    titleText: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset(
        //   AppAssets.keyholeWhite,
        //   height: 24,
        //   width: 24,
        //   color: textColor,
        // ),
        // horizontalSpace(),
        Flexible(
          child: text(
            message,
            size: 16,
            color: textColor,
            weight: FontWeight.w600,
          ),
        ),
      ],
    ),
    snackStyle: SnackStyle.FLOATING,
    colorText: Colors.white,
    shouldIconPulse: false,
    borderRadius: 4,
    margin: margin ??
        EdgeInsets.only(
          top: eqH(33),
          left: eqW(16),
          right: eqW(16),
        ),
  );
}
