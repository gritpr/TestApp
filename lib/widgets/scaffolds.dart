import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../__lib.dart';

class BaseScaffold extends StatelessWidget {
  final String? appBarTitle;
  final String? leadingIcon;
  final Widget child;
  final bool addBottomPaddding;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final ObstructingPreferredSizeWidget? navigationBar;
  final Color? color;
  final Function()? onBackPressed;
  final Widget? trailingButton;

  final bool noLeadingIcon;

  final bool noAppBarDivider;

  const BaseScaffold({
    Key? key,
    this.onBackPressed,
    this.appBarTitle,
    this.leadingIcon,
    this.navigationBar,
    this.isLoading = false,
    required this.child,
    this.color,
    this.addBottomPaddding = false,
    this.padding,
    this.trailingButton,
    this.noLeadingIcon = false,
    this.noAppBarDivider = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, orientation) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              col(
                children: [
                  verticalSpace(height: appBarTitle == null ? 27 : 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!noLeadingIcon)
                        IconButton(
                          icon:
                              Image.asset(leadingIcon ?? AppAssets.backButton),
                          onPressed: () {
                            onBackPressed ?? pop();
                          },
                        ),
                      if (appBarTitle != null)
                        text(
                          appBarTitle,
                          weight: FontWeight.w900,
                          size: 17,
                        ),
                      const SizedBox(
                        width: 32,
                      )
                    ],
                  ),
                  if (appBarTitle != null && !noAppBarDivider) divider(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(padding: pad(horiz: 16.0), child: child),
                    ),
                  ),
                ],
              ),
              if (isLoading) loaderScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
