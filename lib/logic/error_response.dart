import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable(
  disallowUnrecognizedKeys: true,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class ErrorResponse {
  final String? error;
  final String message;
  final String? remedy;
  final String? uri;

  ErrorResponse(this.message, {this.error, this.remedy, this.uri});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  factory ErrorResponse.initial() {
    return ErrorResponse('', error: '', remedy: '', uri: '');
  }
}
