import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../model/identifier.dart';

part 'word.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Word extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> texts;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> contents;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> images;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> payloads;

  final List<Identifier> examples;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<String> maya;

  const Word({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.type,
    required this.texts,
    required this.contents,
    required this.images,
    required this.payloads,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required this.maya,
    required this.examples,
  });

  factory Word.initial() {
    return Word(
      sku: '',
      version: 0,
      ordinal: -1,
      texts: [],
      contents: [],
      images: [],
      payloads: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      maya: [],
      type: '',
      examples: [],
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Word && other.sku == sku && other.ordinal == ordinal;
  }

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WordToJson(this);
}
