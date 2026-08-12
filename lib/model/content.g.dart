// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map json) => $checkedCreate('Content', json, (
  $checkedConvert,
) {
  final val = Content(
    sku: $checkedConvert('sku', (v) => v as String? ?? ''),
    version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
    ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? 0),
    languages: $checkedConvert(
      'languages',
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
    payloads: $checkedConvert(
      'payloads',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Payload.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
  );
  return val;
});

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': instance.createdBy?.toJson(),
  'lastModifiedBy': instance.lastModifiedBy?.toJson(),
  'version': instance.version,
  'sku': instance.sku,
  'ordinal': instance.ordinal,
  'languages': instance.languages.map((e) => e.toJson()).toList(),
  'payloads': instance.payloads.map((e) => e.toJson()).toList(),
};
