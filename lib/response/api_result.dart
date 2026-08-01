import 'package:json_annotation/json_annotation.dart';

part 'api_result.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  dateTimeUtc: true,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class ApiResult<T> {
  final bool success;

  @JsonKey(includeIfNull: false, defaultValue: '')
  final String message;

  final T payload;

  const ApiResult({
    required this.success,
    required this.message,
    required this.payload,
  });

  // ✅ Named constructor instead of factory
  const ApiResult.initial() : success = true, message = '', payload = null as T;

  ApiResult copyWith({bool? success, String? message, T? payload}) {
    return ApiResult(
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
