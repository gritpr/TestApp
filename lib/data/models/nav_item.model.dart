// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavItem extends Equatable {
  final Widget? body;
  final String? title;
  final String? content;
  final unselectedImgPath;
  final selectedImgPath;
  final bool isIcon;
  Function()? onTap;
  final bool hideIcon;
  final Color? color;

  @override
  List<Object?> get props => [title];
  
  NavItem({
    this.color,
    this.content,
    this.onTap,
    this.body,
    this.title,
    this.isIcon = true,
    this.hideIcon = false,
    this.unselectedImgPath,
    this.selectedImgPath,
  });
}
