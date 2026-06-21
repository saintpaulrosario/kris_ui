// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map json) => $checkedCreate(
  'ErrorResponse',
  json,
  ($checkedConvert) {
    $checkKeys(json, allowedKeys: const ['error', 'message', 'remedy', 'uri']);
    final val = ErrorResponse(
      $checkedConvert('message', (v) => v as String),
      error: $checkedConvert('error', (v) => v as String?),
      remedy: $checkedConvert('remedy', (v) => v as String?),
      uri: $checkedConvert('uri', (v) => v as String?),
    );
    return val;
  },
);

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'remedy': instance.remedy,
      'uri': instance.uri,
    };
