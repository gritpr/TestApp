// ignore_for_file: must_be_immutable

import 'package:mhub/data/models/network_response.dart';

class GetProductResponse extends EmptyResponse{
  String? message;
  bool? success;
  int? statusCode;
  List<Product>? data;

  GetProductResponse({this.message, this.success, this.statusCode, this.data});

  GetProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
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

class Product {
  String? sId;
  String? name;
  int? price;
  int? initialQuantity;
  int? soldQuantity;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Product(
      {this.sId,
      this.name,
      this.price,
      this.initialQuantity,
      this.soldQuantity,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    initialQuantity = json['initialQuantity'];
    soldQuantity = json['soldQuantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['price'] = price;
    data['initialQuantity'] = initialQuantity;
    data['soldQuantity'] = soldQuantity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
