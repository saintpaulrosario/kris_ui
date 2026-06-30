// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instrument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Instrument _$InstrumentFromJson(Map json) =>
    $checkedCreate('Instrument', json, ($checkedConvert) {
      final val = Instrument(
        payload: $checkedConvert('payload', (v) => v as String),
        contentType: $checkedConvert('contentType', (v) => v as String),
        size: $checkedConvert('size', (v) => (v as num).toInt()),
        description: $checkedConvert('description', (v) => v as String? ?? ''),
        tags: $checkedConvert(
          'tags',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
        ),
        sku: $checkedConvert('sku', (v) => v as String? ?? ''),
        version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? -1),
        row: $checkedConvert('row', (v) => (v as num?)?.toInt() ?? -1),
        ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? -1),
        createdDate: $checkedConvert(
          'createdDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        lastModifiedDate: $checkedConvert(
          'lastModifiedDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        createdBy: $checkedConvert('createdBy', (v) => v as String?),
        lastModifiedBy: $checkedConvert('lastModifiedBy', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$InstrumentToJson(Instrument instance) =>
    <String, dynamic>{
      'createdDate': ?instance.createdDate?.toIso8601String(),
      'lastModifiedDate': ?instance.lastModifiedDate?.toIso8601String(),
      'createdBy': ?instance.createdBy,
      'lastModifiedBy': ?instance.lastModifiedBy,
      'sku': instance.sku,
      'version': instance.version,
      'row': instance.row,
      'ordinal': instance.ordinal,
      'payload': instance.payload,
      'contentType': instance.contentType,
      'size': instance.size,
      'description': instance.description,
      'tags': instance.tags,
    };
