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
        createdBy: $checkedConvert('createdBy', (v) => v as String?),
        lastModifiedBy: $checkedConvert('lastModifiedBy', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AuditToJson(Audit instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': ?instance.createdBy,
  'lastModifiedBy': ?instance.lastModifiedBy,
};
