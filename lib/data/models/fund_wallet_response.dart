// ignore_for_file: must_be_immutable

import 'package:mhub/data/models/network_response.dart';

class FundWalletResponse extends EmptyResponse {
  String? message;
  bool? success;
  int? statusCode;
  FundWalletData? data;

  FundWalletResponse({this.message, this.success, this.statusCode, this.data});

  FundWalletResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? FundWalletData.fromJson(json['data']) : null;
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

class FundWalletData {
  String? sId;
  String? name;
  String? email;
  String? otp;
  bool? verified;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? wallet;

  FundWalletData(
      {this.sId,
      this.name,
      this.email,
      this.otp,
      this.verified,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.wallet});

  FundWalletData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    otp = json['otp'];
    verified = json['verified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['otp'] = otp;
    data['verified'] = verified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['wallet'] = wallet;
    return data;
  }
}
