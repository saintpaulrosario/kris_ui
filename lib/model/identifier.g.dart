// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Identifier _$IdentifierFromJson(Map json) =>
    $checkedCreate('Identifier', json, ($checkedConvert) {
      final val = Identifier(
        sku: $checkedConvert('sku', (v) => v as String? ?? ''),
        ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? 0),
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
        version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
      );
      return val;
    });

Map<String, dynamic> _$IdentifierToJson(Identifier instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
      'createdBy': instance.createdBy?.toJson(),
      'lastModifiedBy': instance.lastModifiedBy?.toJson(),
      'version': instance.version,
      'sku': instance.sku,
      'ordinal': instance.ordinal,
    };
