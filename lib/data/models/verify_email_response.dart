// ignore_for_file: must_be_immutable

import '../../__lib.dart';

class VerifyEmailResponse extends EmptyResponse{
  String? message;
  bool? success;
  int? statusCode;
  User? data;

  VerifyEmailResponse({this.message, this.success, this.statusCode, this.data});

  VerifyEmailResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
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

