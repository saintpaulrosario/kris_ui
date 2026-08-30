// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Example _$ExampleFromJson(Map json) => $checkedCreate('Example', json, (
  $checkedConvert,
) {
  $checkKeys(json, disallowNullValues: const ['sku', 'ordinal', 'rows']);
  final val = Example(
    sku: $checkedConvert('sku', (v) => v as String),
    version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
    ordinal: $checkedConvert('ordinal', (v) => (v as num).toInt()),
    texts: $checkedConvert(
      'texts',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    traits: $checkedConvert(
      'traits',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
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
    images: $checkedConvert(
      'images',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    rows: $checkedConvert(
      'rows',
      (v) => (v as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    ),
    definition: $checkedConvert(
      'definition',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
  );
  return val;
});

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': instance.createdBy?.toJson(),
  'lastModifiedBy': instance.lastModifiedBy?.toJson(),
  'version': instance.version,
  'sku': instance.sku,
  'ordinal': instance.ordinal,
  'texts': instance.texts.map((e) => e.toJson()).toList(),
  'rows': instance.rows,
  'traits': instance.traits.map((e) => e.toJson()).toList(),
  'images': instance.images.map((e) => e.toJson()).toList(),
  'definition': instance.definition.toJson(),
};
