// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medium.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medium _$MediumFromJson(Map json) =>
    $checkedCreate('Medium', json, ($checkedConvert) {
      final val = Medium(
        content: $checkedConvert('content', (v) => v as String? ?? ''),
        contentType: $checkedConvert('contentType', (v) => v as String? ?? ''),
        size: $checkedConvert('size', (v) => (v as num?)?.toInt() ?? 0),
        description: $checkedConvert('description', (v) => v as String? ?? ''),
        tags: $checkedConvert(
          'tags',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
        ),
        sku: $checkedConvert('sku', (v) => v as String? ?? ''),
        version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
        ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? 0),
        createdDate: $checkedConvert(
          'createdDate',
          (v) => DateTime.parse(v as String),
        ),
        lastModifiedDate: $checkedConvert(
          'lastModifiedDate',
          (v) => DateTime.parse(v as String),
        ),
        createdBy: $checkedConvert('createdBy', (v) => v as String?),
        lastModifiedBy: $checkedConvert('lastModifiedBy', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$MediumToJson(Medium instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': ?instance.createdBy,
  'lastModifiedBy': ?instance.lastModifiedBy,
  'version': instance.version,
  'sku': instance.sku,
  'ordinal': instance.ordinal,
  'content': instance.content,
  'contentType': instance.contentType,
  'size': instance.size,
  'description': instance.description,
  'tags': instance.tags,
};
