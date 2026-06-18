// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult<T> _$ApiResultFromJson<T>(
  Map json,
  T Function(Object? json) fromJsonT,
) => $checkedCreate('ApiResult', json, ($checkedConvert) {
  final val = ApiResult<T>(
    success: $checkedConvert('success', (v) => v as bool),
    message: $checkedConvert('message', (v) => v as String? ?? ''),
    payload: $checkedConvert('payload', (v) => fromJsonT(v)),
  );
  return val;
});

Map<String, dynamic> _$ApiResultToJson<T>(
  ApiResult<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'payload': toJsonT(instance.payload),
};
