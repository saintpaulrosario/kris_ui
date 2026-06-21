// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Script _$ScriptFromJson(Map json) =>
    $checkedCreate('Script', json, ($checkedConvert) {
      final val = Script(
        text: $checkedConvert(
          'text',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) =>
                        Identity.fromJson(Map<String, dynamic>.from(e as Map)),
                  )
                  .toList() ??
              [],
        ),
        contents: $checkedConvert(
          'contents',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) =>
                        Content.fromJson(Map<String, dynamic>.from(e as Map)),
                  )
                  .toList() ??
              [],
        ),
        types: $checkedConvert(
          'types',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
        ),
      );
      return val;
    });

Map<String, dynamic> _$ScriptToJson(Script instance) => <String, dynamic>{
  'text': instance.text?.map((e) => e.toJson()).toList(),
  'contents': instance.contents?.map((e) => e.toJson()).toList(),
  'types': instance.types,
};
