// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordText _$WordTextFromJson(Map json) => $checkedCreate('WordText', json, (
  $checkedConvert,
) {
  final val = WordText(
    sku: $checkedConvert('sku', (v) => v as String? ?? ''),
    version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? -1),
    row: $checkedConvert('row', (v) => (v as num?)?.toInt() ?? -1),
    ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? -1),
    dialects: $checkedConvert(
      'dialects',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    contents: $checkedConvert(
      'contents',
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
    word: $checkedConvert(
      'word',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    script: $checkedConvert(
      'script',
      (v) => v == null
          ? null
          : Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    types: $checkedConvert(
      'types',
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

Map<String, dynamic> _$WordTextToJson(WordText instance) => <String, dynamic>{
  'sku': instance.sku,
  'version': instance.version,
  'row': instance.row,
  'ordinal': instance.ordinal,
  'word': instance.word.toJson(),
  'script': instance.script?.toJson(),
  'languages': instance.languages.map((e) => e.toJson()).toList(),
  'dialects': instance.dialects.map((e) => e.toJson()).toList(),
  'types': instance.types.map((e) => e.toJson()).toList(),
  'contents': instance.contents.map((e) => e.toJson()).toList(),
};
