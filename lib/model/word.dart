import 'package:json_annotation/json_annotation.dart';

import 'idenity.dart';

part 'word.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Word extends Identity {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identity> texts;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identity> contents;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identity> images;

  Word({
    required super.sku,
    required super.version,
    required super.row,
    required super.ordinal,
    required this.texts,
    required this.contents,
    required this.images,
  });

  factory Word.initial() {
    return Word(
      sku: '',
      version: 0,
      row: 0,
      ordinal: 0,
      texts: [],
      contents: [],
      images: [],
    );
  }

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WordToJson(this);
}
