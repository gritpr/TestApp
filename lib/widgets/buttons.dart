import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../__lib.dart';

Widget iconButton({
  required String iconPath,
  required String label,
  double size = 40,
  required Function()? onTap,
  Color? labelColor,
}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        assetsImage(
          iconPath,
          width: eqW(size),
          height: eqH(size),
        ),
        verticalSpace(height: 4),
        text(
          label,
          weight: FontWeight.w500,
          color: labelColor ?? AppColors.c5A5B6A,
        ),
      ],
    ),
  );
}

Widget slimButton(
    {required onPressed,
    required Widget child,
    Color? bgColor,
    double? elevation}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: child,
    style: ElevatedButton.styleFrom(
      primary: bgColor ?? AppColors.brandBlue,
      elevation: elevation ?? 0,
      padding: pad(horiz: 24, vert: 16),
    ),
  );
}

Widget wideButton({
  required void Function()? onPressed,
  required String label,
  double? labelFontSize,
  Color? labelColor,
  FontWeight? labelFontWeight,
  Color? bgColor,
  Color? disabledColor,
  bool isLoading = false,
  double elevation = 0,
  String? iconPath,
}) {
  return MaterialButton(
    elevation: elevation,
    color: bgColor ?? AppColors.brandBlue,
    onPressed: isLoading
        ? () {
            log('Tapped While Loading');
          }
        : onPressed,
    disabledColor: disabledColor ?? AppColors.brandBlue.withOpacity(.2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: isLoading
          ? Transform.scale(
              scale: .5,
              child: const CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconPath != null)
                  Image.asset(iconPath, width: 20, height: 20),
                if (iconPath != null) horizontalSpace(width: 12),
                text(
                  label,
                  color: labelColor ?? AppColors.white,
                  weight: labelFontWeight ?? FontWeight.w700,
                  size: labelFontSize ?? 14,
                )
              ],
            ),
    ),
    padding: isLoading ? pad(vert: 10) : pad(vert: 17),
  );
}

Widget outlineButton({
  required void Function()? onPressed,
  required String label,
  double? labelFontSize,
  Color? labelColor,
  FontWeight? labelFontWeight,
  Color? rimColor,
  bool isLoading = false,
  EdgeInsetsGeometry? padding,
}) {
  return InkWell(
    onTap: isLoading
        ? () {
            log('Tapped While Loading');
          }
        : onPressed,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: rimColor ?? AppColors.brandBlue,
          width: 2,
        ),
      ),
      child: Center(
        child: isLoading
            ? Transform.scale(
                scale: .5,
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : text(
                label,
                color: labelColor ?? AppColors.brandBlue,
                weight: labelFontWeight ?? FontWeight.w600,
                size: labelFontSize ?? 14,
              ),
      ),
      padding: padding ?? pad(vert: 17),
    ),
  );
}

Widget urlButton(String label, String url) {
  return InkWell(
    onTap: () {
      launchUrl(Uri.parse(url));
    },
    child: Padding(
      padding: pad(vert: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: text(
          label,
        ),
      ),
    ),
  );
}


Widget smoothButton({
  required Color bgColor,
  required Color textColor,
  Color? iconColor,
  String? iconImgPath,
  IconData? icon,
  required String label,
  Function()? onTap,
  FontWeight? fontWeight,
  double? iconsSize = 16,
  double? textSize,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: pad(vert: 4, horiz: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconImgPath != null) assetsImage(iconImgPath, both: iconsSize),
          if (iconImgPath != null) horizontalSpace(width: 10),
          text(
            label,
            size: textSize ?? 11,
            color: textColor,
            maxLines: 1,
            weight: fontWeight ?? FontWeight.w600,
          ),
        ],
      ),
    ),
  );
}

Widget spanTextButton({required String firstSpan, required String secondSpan}) {
  return Align(
    alignment: Alignment.center,
    child: InkWell(
      onTap: () {
        // pushScreen(EnterEmailStepScreen(), removeSession: true);
      },
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.lato(color: AppColors.cA1A1A1, fontSize: 11),
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
  );
}
