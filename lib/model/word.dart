import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/instruction.dart';

import 'identifier.dart';

part 'word.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Word extends Instruction {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> texts;

  // @JsonKey(disallowNullValue: false, defaultValue: [])
  // final List<Identifier> examples;

  const Word({
    required super.sku,
    required super.version,
    required super.ordinal,
    required this.texts,
    //required this.examples,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.images,
  });

  factory Word.initial() {
    return Word(
      sku: '',
      version: 0,
      ordinal: 0,
      texts: [],
      images: [],
      //examples: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
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
