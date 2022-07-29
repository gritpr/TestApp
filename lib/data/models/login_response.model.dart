// ignore_for_file: must_be_immutable

import '../../__lib.dart';

class LogInResponse extends EmptyResponse{
  String? message;
  bool? success;
  int? statusCode;
  LogInData? data;

  LogInResponse({this.message, this.success, this.statusCode, this.data});

  LogInResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? LogInData.fromJson(json['data']) : null;
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

class LogInData {
  String? token;
  String? userId;

  LogInData({this.token, this.userId});

  LogInData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['userId'] = userId;
    return data;
  }
}

