// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map json) => $checkedCreate('Language', json, (
  $checkedConvert,
) {
  final val = Language(
    sku: $checkedConvert('sku', (v) => v as String? ?? ''),
    version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
    ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? 0),
    texts: $checkedConvert(
      'texts',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => Text.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
    ),
    scripts: $checkedConvert(
      'scripts',
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
      (v) => (v as List<dynamic>)
          .map((e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': instance.createdBy?.toJson(),
  'lastModifiedBy': instance.lastModifiedBy?.toJson(),
  'version': instance.version,
  'sku': instance.sku,
  'ordinal': instance.ordinal,
  'texts': instance.texts.map((e) => e.toJson()).toList(),
  'images': instance.images.map((e) => e.toJson()).toList(),
  'scripts': instance.scripts.map((e) => e.toJson()).toList(),
};
