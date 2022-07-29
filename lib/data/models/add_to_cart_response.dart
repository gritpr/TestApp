// ignore_for_file: must_be_immutable

import 'package:mhub/data/models/network_response.dart';

class AddToCartResponse extends EmptyResponse{
  String? message;
  bool? success;
  int? statusCode;
  AddToCartData? data;

  AddToCartResponse({this.message, this.success, this.statusCode, this.data});

  AddToCartResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? AddToCartData.fromJson(json['data']) : null;
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

class AddToCartData {
  String? userId;
  String? orderId;
  int? total;
  String? status;
  String? sId;
  List<Items>? items;
  int? iV;

  AddToCartData(
      {this.userId,
      this.orderId,
      this.total,
      this.status,
      this.sId,
      this.items,
      this.iV});

  AddToCartData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    orderId = json['orderId'];
    total = json['total'];
    status = json['status'];
    sId = json['_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['orderId'] = orderId;
    data['total'] = total;
    data['status'] = status;
    data['_id'] = sId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

class Items {
  String? productId;
  int? quantity;
  int? amount;
  String? sId;

  Items({this.productId, this.quantity, this.amount, this.sId});

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
    amount = json['amount'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['_id'] = sId;
    return data;
  }
}
