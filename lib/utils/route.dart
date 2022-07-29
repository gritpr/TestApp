import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../__lib.dart';

Future push(String routeName) async {
  return Navigator.pushNamed(Get.context!, routeName);
}

Future pushScreen(Widget widget, {context, bool removeSession = false}) async {
  return Navigator.push(
    context ?? Get.context!,
    CupertinoPageRoute(
      builder: (c) => widget
          // : Consumer(
          //     builder: (BuildContext context, watch, Widget? child) {
          //       final vm = watch(sessionViewModel);
          //       return GestureDetector(
          //         onTap: vm.userActivityDetected,
          //         onPanDown: vm.userActivityDetected,
          //         onScaleStart: vm.userActivityDetected,
          //         child: widget,
          //       );
          //     },
          //   ),
    ),
  );
}

Future replaceScreen(Widget widget,
    {context, bool removeSession = false}) async {
  return await Navigator.pushAndRemoveUntil<dynamic>(
    context ?? Get.context!,
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => removeSession
          ? GestureDetector(
              onTap: () {
                clearFocus(context);
              },
              child: widget)
          : Consumer(
              builder: (BuildContext context, watch, Widget? child) {
               // final vm = watch(sessionViewModel);
                return GestureDetector(
                  onTap: () {
                    clearFocus(context);
                 //   vm.userActivityDetected();
                  },
                  // onPanDown: vm.userActivityDetected,
                  // onScaleStart: vm.userActivityDetected,
                  child: widget,
                );
              },
            ),
    ),
    (route) => false,
  );
}

void clearFocus(BuildContext context) {
  log('clearFocus');
  FocusScope.of(context).requestFocus(FocusNode());
}

pop() {
  Navigator.pop(Get.context!);
}

class NavigatePageRoute extends CupertinoPageRoute {
  late Widget _page;

  NavigatePageRoute(BuildContext context, Widget page)
      : super(builder: (context) => page) {
    _page = page;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(opacity: animation, child: _page);
  }
}
