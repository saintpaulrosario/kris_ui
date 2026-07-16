// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sound _$SoundFromJson(Map json) =>
    $checkedCreate('Sound', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'createdDate',
          'lastModifiedDate',
          'createdBy',
          'lastModifiedBy',
          'sku',
          'version',
          'ordinal',
          'type',
          'payload',
          'contentType',
          'size',
          'description',
          'tags',
        ],
      );
      final val = Sound(
        payload: $checkedConvert('payload', (v) => v as String? ?? ''),
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
        type: $checkedConvert('type', (v) => v as String? ?? ''),
      );
      return val;
    });

Map<String, dynamic> _$SoundToJson(Sound instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': instance.createdBy,
  'lastModifiedBy': instance.lastModifiedBy,
  'sku': instance.sku,
  'version': instance.version,
  'ordinal': instance.ordinal,
  'type': instance.type,
  'payload': instance.payload,
  'contentType': instance.contentType,
  'size': instance.size,
  'description': instance.description,
  'tags': instance.tags,
};
