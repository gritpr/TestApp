// ignore_for_file: import_of_legacy_library_into_null_safe


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../__lib.dart';

Widget inputFeild(
    {required String label,
    required TextEditingController controller,
    String? hint,
    int? maxLines,
    int? minLines,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    keyboardType}) {
  return col(
    children: [
      text(label, color: AppColors.cBDBDBD),
      if (label.isNotEmpty) verticalSpace(height: 8),
      TextFormField(
        maxLines: maxLines,
        minLines: minLines,
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: const TextStyle(fontWeight: FontWeight.w600),
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 30, minHeight: 0),
          prefixIconColor: AppColors.cCDCDCD,
          suffixIcon: suffixIcon,
          suffixIconConstraints:
              const BoxConstraints(minWidth: 30, minHeight: 16),
          hintText: hint,
          hintStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 14),
          filled: true,
          fillColor: AppColors.cF7F7F7,
          contentPadding: pad(horiz: 12, vert: 14),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.cF7F7F7),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.cF7F7F7),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.cF7F7F7),
          ),
        ),
        validator: validator,
      ),
    ],
  );
}




Widget passwordFeild({
  String label = 'Password',
  required TextEditingController controller,
  required onToggleVisibility,
  required bool showPassword,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
  Function(String)? onChanged,
  TextInputAction? textInputAction = TextInputAction.next,
  List<TextInputFormatter>? inputFormatters,
}) {
  return col(
    children: [
      text(label, color: AppColors.cBDBDBD),
      verticalSpace(height: 3),
      TextFormField(
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        onChanged: onChanged,
        textInputAction: textInputAction,
        validator: validator,
        controller: controller,
        obscureText: !showPassword,
        style: const TextStyle(fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          contentPadding: pad(horiz: 12),
          errorMaxLines: 3,
          filled: true,
          fillColor: AppColors.cF7F7F7,
          hintStyle:const TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: AppColors.cF7F7F7),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: InkWell(
            onTap: onToggleVisibility,
            child: Padding(
              padding: pad(horiz: 16, vert: 16),
              child: Image.asset(showPassword ? AppAssets.eye : AppAssets.eye),
            ),
          ),
        ),
      ),
    ],
  );
}



Widget dropDownField({
  Widget? hint,
  String? Function(Object?)? validator,
  required String label,
  Object? value,
  required Function(Object?)? onChanged,
  required List<DropdownMenuItem<Object>>? items,
  bool isExpanded = true,
}) {
  return col(
    children: [
      text(label, size: 12, color: AppColors.cBDBDBD),
      verticalSpace(height: 8),
      DropdownButtonFormField(
        decoration: InputDecoration(
          contentPadding: pad(
            horiz: 14,
          ),
          filled: true,
          fillColor: AppColors.cF7F7F7,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.cF7F7F7,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.cF7F7F7,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        hint: hint,
        value: value,
        isExpanded: isExpanded,
        onChanged: onChanged,
        validator: validator,
        items: items,
      ),
    ],
  );
}


