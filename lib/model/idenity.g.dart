// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idenity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Identity _$IdentityFromJson(Map json) =>
    $checkedCreate('Identity', json, ($checkedConvert) {
      final val = Identity(
        sku: $checkedConvert('sku', (v) => v as String? ?? ''),
        version: $checkedConvert('version', (v) => (v as num).toInt()),
        row: $checkedConvert('row', (v) => (v as num?)?.toInt() ?? -1),
        ordinal: $checkedConvert('ordinal', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$IdentityToJson(Identity instance) => <String, dynamic>{
  'sku': instance.sku,
  'version': instance.version,
  'row': instance.row,
  'ordinal': instance.ordinal,
};
