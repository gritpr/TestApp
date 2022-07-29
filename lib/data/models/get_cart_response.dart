// ignore_for_file: must_be_immutable

import 'package:mhub/data/models/network_response.dart';

class GetCartResponse extends EmptyResponse{
  String? message;
  bool? success;
  int? statusCode;
  List<CartData>? data;

  GetCartResponse({this.message, this.success, this.statusCode, this.data});

  GetCartResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data!.add(CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  String? sId;
  String? userId;
  String? orderId;
  int? total;
  String? status;
  List<CartItem>? items;
  int? iV;

  CartData(
      {this.sId,
      this.userId,
      this.orderId,
      this.total,
      this.status,
      this.items,
      this.iV});

  CartData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    orderId = json['orderId'];
    total = json['total'];
    status = json['status'];
    if (json['items'] != null) {
      items = <CartItem>[];
      json['items'].forEach((v) {
        items!.add(CartItem.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['orderId'] = orderId;
    data['total'] = total;
    data['status'] = status;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

class CartItem {
  String? productId;
  int? quantity;
  int? amount;
  String? sId;

  CartItem({this.productId, this.quantity, this.amount, this.sId});

  CartItem.fromJson(Map<String, dynamic> json) {
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
