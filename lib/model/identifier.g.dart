// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Identifier _$IdentifierFromJson(Map json) =>
    $checkedCreate('Identifier', json, ($checkedConvert) {
      final val = Identifier(
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

Map<String, dynamic> _$IdentifierToJson(Identifier instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate?.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'lastModifiedBy': instance.lastModifiedBy,
      'sku': instance.sku,
      'version': instance.version,
      'row': instance.row,
      'ordinal': instance.ordinal,
    };
