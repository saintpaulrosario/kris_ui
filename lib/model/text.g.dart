// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Text _$TextFromJson(Map json) =>
    $checkedCreate('Text', json, ($checkedConvert) {
      final val = Text(
        sku: $checkedConvert('sku', (v) => v as String? ?? ''),
        version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
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
        script: $checkedConvert(
          'script',
          (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
        ),
        word: $checkedConvert(
          'word',
          (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
        ),
        contents: $checkedConvert(
          'contents',
          (v) => (v as List<dynamic>)
              .map((e) => Content.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TextToJson(Text instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': instance.createdBy?.toJson(),
  'lastModifiedBy': instance.lastModifiedBy?.toJson(),
  'version': instance.version,
  'sku': instance.sku,
  'ordinal': instance.ordinal,
  'script': instance.script.toJson(),
  'word': instance.word.toJson(),
  'contents': instance.contents.map((e) => e.toJson()).toList(),
};
