// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Identifier _$IdentifierFromJson(Map json) =>
    $checkedCreate('Identifier', json, ($checkedConvert) {
      final val = Identifier(
        sku: $checkedConvert('sku', (v) => v as String? ?? ''),
        version: $checkedConvert('version', (v) => (v as num).toInt()),
        row: $checkedConvert('row', (v) => (v as num?)?.toInt() ?? -1),
        ordinal: $checkedConvert('ordinal', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$IdentifierToJson(Identifier instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'version': instance.version,
      'row': instance.row,
      'ordinal': instance.ordinal,
    };
