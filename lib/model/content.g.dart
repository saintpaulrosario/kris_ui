// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map json) =>
    $checkedCreate('Content', json, ($checkedConvert) {
      final val = Content(
        payload: $checkedConvert('payload', (v) => v as String? ?? ''),
        types: $checkedConvert(
          'types',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        word: $checkedConvert(
          'word',
          (v) => v == null
              ? null
              : Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
        ),
        text: $checkedConvert(
          'text',
          (v) => v == null
              ? null
              : Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'payload': instance.payload,
  'types': instance.types,
  'word': instance.word?.toJson(),
  'text': instance.text?.toJson(),
};
