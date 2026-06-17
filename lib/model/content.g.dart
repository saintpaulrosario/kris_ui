// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map json) =>
    $checkedCreate('Content', json, ($checkedConvert) {
      final val = Content(
        payload: $checkedConvert('payload', (v) => v as String?),
        type: $checkedConvert('type', (v) => v as String?),
        word: $checkedConvert(
          'word',
          (v) => v == null
              ? null
              : Identity.fromJson(Map<String, dynamic>.from(v as Map)),
        ),
        text: $checkedConvert(
          'text',
          (v) => v == null
              ? null
              : Identity.fromJson(Map<String, dynamic>.from(v as Map)),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'payload': ?instance.payload,
  'type': ?instance.type,
  'word': ?instance.word?.toJson(),
  'text': ?instance.text?.toJson(),
};
