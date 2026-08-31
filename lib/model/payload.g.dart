// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payload _$PayloadFromJson(Map json) => $checkedCreate('Payload', json, (
  $checkedConvert,
) {
  $checkKeys(json, disallowNullValues: const ['sku', 'ordinal']);
  final val = Payload(
    sku: $checkedConvert('sku', (v) => v as String),
    version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
    ordinal: $checkedConvert('ordinal', (v) => (v as num).toInt()),
    value: $checkedConvert('value', (v) => v as String? ?? ''),
    dialects: $checkedConvert(
      'dialects',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    createdDate: $checkedConvert(
      'createdDate',
      (v) => DateTime.parse(v as String),
    ),
    lastModifiedDate: $checkedConvert(
      'lastModifiedDate',
      (v) => DateTime.parse(v as String),
    ),
    createdBy: $checkedConvert(
      'createdBy',
      (v) => v == null
          ? null
          : Account.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    lastModifiedBy: $checkedConvert(
      'lastModifiedBy',
      (v) => v == null
          ? null
          : Account.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    audios: $checkedConvert(
      'audios',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    traits: $checkedConvert(
      'traits',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    rows: $checkedConvert(
      'rows',
      (v) =>
          (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList() ?? [],
    ),
    language: $checkedConvert(
      'language',
      (v) => v == null
          ? null
          : Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    types: $checkedConvert(
      'types',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
  );
  return val;
});

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': instance.createdBy?.toJson(),
  'lastModifiedBy': instance.lastModifiedBy?.toJson(),
  'version': instance.version,
  'sku': instance.sku,
  'ordinal': instance.ordinal,
  'value': instance.value,
  'dialects': instance.dialects.map((e) => e.toJson()).toList(),
  'language': instance.language?.toJson(),
  'audios': instance.audios.map((e) => e.toJson()).toList(),
  'traits': instance.traits.map((e) => e.toJson()).toList(),
  'types': instance.types.map((e) => e.toJson()).toList(),
  'rows': instance.rows,
};
