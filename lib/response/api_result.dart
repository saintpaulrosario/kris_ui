import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_result.g.dart';

@immutable
@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  genericArgumentFactories: true,
)
class ApiResult<T> {
  final String code;
  final bool success;
  final String message;
  final T payload;

  const ApiResult({
    required this.code,
    required this.success,
    required this.message,
    required this.payload,
  });

  // ✅ Named constructor instead of factory
  const ApiResult.initial()
    : code = '',
      success = true,
      message = '',
      payload = null as T;

  ApiResult copyWith({
    String? code,
    bool? success,
    String? message,
    dynamic payload,
  }) {
    return ApiResult(
      code: code ?? this.code,
      success: success ?? this.success,
      payload: payload ?? this.payload,
      message: message ?? this.message,
    );
  }

  factory ApiResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ApiResultToJson(this, toJsonT);
}
