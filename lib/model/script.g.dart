// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Script _$ScriptFromJson(Map json) => $checkedCreate('Script', json, (
  $checkedConvert,
) {
  final val = Script(
    contents: $checkedConvert(
      'contents',
      (v) => (v as List<dynamic>?)
          ?.map((e) => Content.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ScriptToJson(Script instance) => <String, dynamic>{
  'contents': ?instance.contents?.map((e) => e.toJson()).toList(),
};
