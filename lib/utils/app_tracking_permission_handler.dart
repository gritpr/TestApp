// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_ios_app_tracking_permission/flutter_ios_app_tracking_permission.dart';

class AppTrackingPermissionHandler {
  static requestTrackingPermisssion(){
    AppTrackingPermission.requestPermission();
  }
}