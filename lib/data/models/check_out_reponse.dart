// ignore_for_file: must_be_immutable

import 'package:mhub/data/models/network_response.dart';

class CheckOutResponse extends EmptyResponse {
  String? message;
  bool? success;
  int? statusCode;
  CheckOutData? data;

  CheckOutResponse({this.message, this.success, this.statusCode, this.data});

  CheckOutResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? CheckOutData.fromJson(json['data']) : null;
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

class CheckOutData {
  String? orderId;
  int? totalAmountPaid;

  CheckOutData({this.orderId, this.totalAmountPaid});

  CheckOutData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    totalAmountPaid = json['totalAmountPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['totalAmountPaid'] = totalAmountPaid;
    return data;
  }
}
