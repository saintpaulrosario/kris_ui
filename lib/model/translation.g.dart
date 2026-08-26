// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Translation _$TranslationFromJson(Map json) => $checkedCreate(
  'Translation',
  json,
  ($checkedConvert) {
    $checkKeys(json, disallowNullValues: const ['sku', 'ordinal', 'rows']);
    final val = Translation(
      sku: $checkedConvert('sku', (v) => v as String),
      version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
      ordinal: $checkedConvert('ordinal', (v) => (v as num).toInt()),
      texts: $checkedConvert(
        'texts',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
      images: $checkedConvert(
        'images',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
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
      rows: $checkedConvert(
        'rows',
        (v) => (v as List<dynamic>).map((e) => (e as num).toInt()).toList(),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$TranslationToJson(Translation instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
      'createdBy': instance.createdBy?.toJson(),
      'lastModifiedBy': instance.lastModifiedBy?.toJson(),
      'version': instance.version,
      'sku': instance.sku,
      'ordinal': instance.ordinal,
      'texts': instance.texts.map((e) => e.toJson()).toList(),
      'rows': instance.rows,
      'images': instance.images.map((e) => e.toJson()).toList(),
    };
