import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../identifier.dart';

part 'payload.g.dart';

@JsonSerializable(
  disallowUnrecognizedKeys: false,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Payload extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: 1)
  final int rank;

  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String value;

  @JsonKey(disallowNullValue: false)
  final Identifier script;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> languages;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> dialects;

  @JsonKey(disallowNullValue: false)
  final Identifier text;

  @JsonKey(disallowNullValue: false)
  final Identifier content;

  // @JsonKey(disallowNullValue: false)
  // final Identifier language;

  @JsonKey(disallowNullValue: false)
  final Identifier word;

  @JsonKey(disallowNullValue: false)
  final Identifier? root;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> examples;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> sounds;

  Payload({
    required this.rank,
    required this.value,
    required this.script,
    required this.text,
    required this.content,
    required this.word,
    required this.sounds,
    required this.languages,
    required this.dialects,
    required this.root,
    required this.examples,
    required super.ordinal,
    required super.sku,
    required super.version,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.type,
  });

  factory Payload.initial() {
    return Payload(
      rank: 0,
      value: '',
      script: Identifier.initial(),
      text: Identifier.initial(),
      content: Identifier.initial(),
      word: Identifier.initial(),
      sounds: [],
      languages: [],
      dialects: [],
      root: Identifier.initial(),
      examples: [],
      ordinal: -1,
      sku: '',
      version: 0,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      type: '',
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Payload && other.sku == sku && other.ordinal == ordinal;
  }

  factory Payload.fromJson(Map<String, dynamic> json) =>
      _$PayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}
