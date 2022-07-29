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

    //   CupertinoPageScaffold(
    //     navigationBar: navigationBar ??
    //              CupertinoNavigationBar(
    //                 middle:appBarTitle== null?null:
    //                     text(appBarTitle, weight: FontWeight.w900, size: 17),
    //                 transitionBetweenRoutes: true,
    //                 leading: GestureDetector(
    //                   onTap: onBackPressed ??
    //                       () {
    //                         pop();
    //                       },
    //                   child: assetsImage(
    //                      leadingIcon ?? AppAssets.backButton,
    //                   ),
    //                 ),
    //                 trailing: Material(child: trailingButton),
    //               )
    //            ,
    //     child: Material(
    //       color: color ?? AppColors.white,
    //       child: Padding(
    //         padding: isLoading ? EdgeInsets.zero : padding ?? pad(both: 16),
    //         child: SafeArea(
    //           child: Stack(
    //             children: [
    //               Container(
    //                 height: double.infinity,
    //                 width: double.infinity,
    //                 child: child,
    //               ),
    //               if (isLoading) loaderScreen(),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

//   static Widget withFab({
//     String? appBarTitle,
//     String? leadingIcon,
//     required Widget child,
//     required fabAction,
//     Widget? fabIcon,
//     bool addBottomPaddding = false,
//     bool isLoading = false,
//     EdgeInsetsGeometry? padding,
//     ObstructingPreferredSizeWidget? navigationBar,
//     Color? color,
//     onBackPressed,
//     Widget? trailingButton,
//   }) {
//     return Scaffold(
//       appBar: navigationBar != null
//           ? navigationBar
//           : appBarTitle != null
//               ? CupertinoNavigationBar(
//                   middle: text(appBarTitle, weight: FontWeight.w600, size: 16),
//                   transitionBetweenRoutes: true,
//                   leading: GestureDetector(
//                     onTap: onBackPressed ??
//                         () {
//                           pop();
//                         },
//                     child: assetsImage(
//                       imgUrl: leadingIcon ?? AppAssets.left,
//                     ),
//                   ),
//                   trailing: trailingButton ?? null,
//                 )
//               : null,
//       body: Material(
//         color: color != null ? color : AppColors.cF5F5F5,
//         child: Padding(
//           padding: padding ?? pad(both: 16),
//           child: SafeArea(
//             child: Stack(
//               children: [
//                 Container(
//                   height: double.infinity,
//                   width: double.infinity,
//                   child: child,
//                 ),
//                 Visibility(
//                   visible: isLoading,
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       child: Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                       height: double.infinity,
//                       width: double.infinity,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppColors.cEC7E3D,
//         onPressed: fabAction,
//         child: fabIcon??Image.asset(
//           AppAssets.fabIcon,
//           height: eqH(36),
//           width: eqW(36),
//           color: AppColors.white,
//         ),
//       ),
//     );
//   }
}

//boyoho5707@vsooc.com
//123.Gbo33
