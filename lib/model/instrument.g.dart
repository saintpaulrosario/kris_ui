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
      );
      return val;
    });

Map<String, dynamic> _$InstrumentToJson(Instrument instance) =>
    <String, dynamic>{
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
