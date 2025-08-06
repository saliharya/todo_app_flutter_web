import 'dart:convert';

import 'package:todo_app_web/utils/error_details.dart';

class BaseResponse<T> {
  T? data;
  ErrorDetails? errorDetails;
  int? code;

  BaseResponse({
    this.data,
    this.errorDetails,
    this.code,
  });

  factory BaseResponse.fromRawJson(String str) =>
      BaseResponse.fromJson(json.decode(str));

  @override
  String toString() => toRawJson();

  String toRawJson() => json.encode(toJson());

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    final error = json['error'];
    return BaseResponse(
      data: json['data'],
      errorDetails: error == null
          ? null
          : ErrorDetails(
        message: error?['message'],
        details: error?['details'],
      ),
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data,
    'error': {
      'message': errorDetails?.message,
      'details': errorDetails?.details,
    },
    'code': code,
  };
}