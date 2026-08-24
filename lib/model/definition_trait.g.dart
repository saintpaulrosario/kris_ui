// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'definition_trait.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefinitionTrait _$DefinitionTraitFromJson(Map json) => $checkedCreate(
  'DefinitionTrait',
  json,
  ($checkedConvert) {
    final val = DefinitionTrait(
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
      dialect: $checkedConvert(
        'dialect',
        (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      payload: $checkedConvert(
        'payload',
        (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      traits: $checkedConvert(
        'traits',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
      type: $checkedConvert(
        'type',
        (v) => v == null
            ? null
            : Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      examples: $checkedConvert(
        'examples',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
      translations: $checkedConvert(
        'translations',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
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

Map<String, dynamic> _$DefinitionTraitToJson(DefinitionTrait instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
      'createdBy': instance.createdBy?.toJson(),
      'lastModifiedBy': instance.lastModifiedBy?.toJson(),
      'version': instance.version,
      'sku': instance.sku,
      'ordinal': instance.ordinal,
      'payload': instance.payload.toJson(),
      'dialect': instance.dialect.toJson(),
      'audios': instance.audios.map((e) => e.toJson()).toList(),
      'traits': instance.traits.map((e) => e.toJson()).toList(),
      'type': instance.type?.toJson(),
      'examples': instance.examples.map((e) => e.toJson()).toList(),
      'translations': instance.translations.map((e) => e.toJson()).toList(),
    };
