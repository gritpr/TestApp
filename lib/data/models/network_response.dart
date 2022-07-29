// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class EmptyResponse extends Equatable{
  @override
  List<Object?> get props =>[];
  
}

class ErrorResponse extends EmptyResponse {

	String? message;
	bool? success;
	int? statusCode;


	ErrorResponse({this.message, this.success, this.statusCode,});

	ErrorResponse.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		success = json['success'];
		statusCode = json['statusCode'];

	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['message'] = message;
		data['success'] = success;
		data['statusCode'] = statusCode;
		
		return data;
	}
}



