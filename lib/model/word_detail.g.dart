// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordDetail _$WordDetailFromJson(
  Map json,
) => $checkedCreate('WordDetail', json, ($checkedConvert) {
  final val = WordDetail(
    word: $checkedConvert(
      'word',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    images: $checkedConvert(
      'images',
      (v) => (v as List<dynamic>)
          .map((e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    ),
    details: $checkedConvert(
      'details',
      (v) => (v as List<dynamic>)
          .map((e) => WordDetail.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$WordDetailToJson(WordDetail instance) =>
    <String, dynamic>{
      'word': instance.word.toJson(),
      'details': instance.details.map((e) => e.toJson()).toList(),
      'images': instance.images.map((e) => e.toJson()).toList(),
    };
