// ignore_for_file: must_be_immutable

import 'package:mhub/data/models/network_response.dart';

class PasswordResetRequestResponse extends EmptyResponse{
  String? message;
  bool? success;
  int? statusCode;
  ResetRequestData? data;

  PasswordResetRequestResponse(
      {this.message, this.success, this.statusCode, this.data});

  PasswordResetRequestResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? ResetRequestData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ResetRequestData {
  String? userId;

  ResetRequestData({this.userId});

  ResetRequestData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    return data;
  }
}
