import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../__lib.dart';




Text text(
  text, {
  FontWeight? weight,
  double? size,
  Color? color,
  TextAlign? textAlign,
  int? maxLines,
  bool? softWrap
}) {
  return Text(
    
    '$text',
    
    softWrap: softWrap,
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: GoogleFonts.lato(
      fontWeight: weight ?? FontWeight.w400,
      fontSize: size ?? 14,
      color: color ?? AppColors.defTextColor,
    ),
  );
}

Text hintText(
  text, {
  FontWeight weight = FontWeight.w500,
  double? size,
  Color? color,
  TextAlign? textAlign,
  int? maxLines,
}) {
  return Text(
    '$text',
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: GoogleFonts.lato(
      fontWeight: weight,
      fontSize: size ?? 14,
      color: color ?? Colors.grey,
    ),
  );
}

Text boldText(
  String t, {
  double? size,
  Color? color,
  TextAlign? textAlign,
  int? maxLines,
}) {
  return text(
    t,
    maxLines: maxLines,
    size: size ?? 25,
    color: color,
    textAlign: textAlign,
    weight: FontWeight.w700,
  );
}

Text mediumText(
  String t, {
  double? size,
  Color? color,
  TextAlign? textAlign,
  int? maxLines,
}) {
  return text(
    t,
    size: size ?? 14,
    maxLines: maxLines,
    color: color,
    textAlign: textAlign,
    weight: FontWeight.w400,
  );
}

Text lightText(
  t, {
  double? size,
  Color? color,
  TextAlign? textAlign,
  int? maxLines,
}) {
  return text(
    t,
    size: size ?? 16,
    color: color,
    maxLines: maxLines,
    textAlign: textAlign,
    weight: FontWeight.w500,
  );
}


