// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dialect _$DialectFromJson(Map json) => $checkedCreate('Dialect', json, (
  $checkedConvert,
) {
  final val = Dialect(
    sku: $checkedConvert('sku', (v) => v as String? ?? ''),
    version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
    ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? 0),
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
    languages: $checkedConvert(
      'languages',
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
    createdBy: $checkedConvert('createdBy', (v) => v as String?),
    lastModifiedBy: $checkedConvert('lastModifiedBy', (v) => v as String?),
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
  );
  return val;
});

Map<String, dynamic> _$DialectToJson(Dialect instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': instance.createdBy,
  'lastModifiedBy': instance.lastModifiedBy,
  'version': instance.version,
  'sku': instance.sku,
  'ordinal': instance.ordinal,
  'images': instance.images.map((e) => e.toJson()).toList(),
  'texts': instance.texts.map((e) => e.toJson()).toList(),
  'languages': instance.languages.map((e) => e.toJson()).toList(),
};
