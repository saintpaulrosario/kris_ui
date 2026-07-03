// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map json) => $checkedCreate('Content', json, (
  $checkedConvert,
) {
  final val = Content(
    payloads: $checkedConvert(
      'payloads',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    text: $checkedConvert(
      'text',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    script: $checkedConvert(
      'script',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    language: $checkedConvert(
      'language',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    word: $checkedConvert(
      'word',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
  );
  return val;
});

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'payloads': instance.payloads.map((e) => e.toJson()).toList(),
  'text': instance.text.toJson(),
  'script': instance.script.toJson(),
  'language': instance.language.toJson(),
  'word': instance.word.toJson(),
};
