// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Audit _$AuditFromJson(Map json) =>
    $checkedCreate('Audit', json, ($checkedConvert) {
      final val = Audit(
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

Map<String, dynamic> _$AuditToJson(Audit instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': ?instance.createdBy?.toJson(),
  'lastModifiedBy': ?instance.lastModifiedBy?.toJson(),
  'version': instance.version,
};
