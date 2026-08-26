// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medium.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medium _$MediumFromJson(Map json) => $checkedCreate('Medium', json, (
  $checkedConvert,
) {
  $checkKeys(json, disallowNullValues: const ['sku', 'ordinal']);
  final val = Medium(
    content: $checkedConvert('content', (v) => v as String? ?? ''),
    type: $checkedConvert('type', (v) => v as String? ?? ''),
    size: $checkedConvert('size', (v) => v as num? ?? 0),
    descriptions: $checkedConvert(
      'descriptions',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    tags: $checkedConvert(
      'tags',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    sku: $checkedConvert('sku', (v) => v as String),
    version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
    ordinal: $checkedConvert('ordinal', (v) => (v as num).toInt()),
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
    checkSum: $checkedConvert('checkSum', (v) => v as String? ?? ''),
    rows: $checkedConvert(
      'rows',
      (v) => (v as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$MediumToJson(Medium instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': ?instance.createdBy?.toJson(),
  'lastModifiedBy': ?instance.lastModifiedBy?.toJson(),
  'version': instance.version,
  'sku': instance.sku,
  'ordinal': instance.ordinal,
  'content': instance.content,
  'type': instance.type,
  'checkSum': instance.checkSum,
  'size': instance.size,
  'descriptions': instance.descriptions.map((e) => e.toJson()).toList(),
  'tags': instance.tags.map((e) => e.toJson()).toList(),
  'rows': instance.rows,
};
