// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_trait.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleTrait _$ExampleTraitFromJson(Map json) => $checkedCreate(
  'ExampleTrait',
  json,
  ($checkedConvert) {
    final val = ExampleTrait(
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
      sku: $checkedConvert('sku', (v) => v as String? ?? ''),
      version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
      ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? 0),
      definitions: $checkedConvert(
        'definitions',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
      payload: $checkedConvert(
        'payload',
        (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      dialect: $checkedConvert(
        'dialect',
        (v) => v == null
            ? null
            : Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      audios: $checkedConvert(
        'audios',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$ExampleTraitToJson(ExampleTrait instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
      'createdBy': instance.createdBy?.toJson(),
      'lastModifiedBy': instance.lastModifiedBy?.toJson(),
      'version': instance.version,
      'sku': instance.sku,
      'ordinal': instance.ordinal,
      'payload': instance.payload.toJson(),
      'dialect': instance.dialect?.toJson(),
      'audios': instance.audios.map((e) => e.toJson()).toList(),
      'definitions': instance.definitions.map((e) => e.toJson()).toList(),
    };
