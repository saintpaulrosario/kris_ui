import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'identifier.dart';

part 'payload.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Payload extends Identifier {
  final int row;
  final String value;
  final Identifier script;
  final Identifier text;
  final Identifier content;
  final Identifier language;
  final Identifier word;
  final List<Identifier> sounds;

  const Payload({
    required this.row,
    required this.value,
    required this.script,
    required this.text,
    required this.content,
    required this.language,
    required this.word,
    required this.sounds,
  }) : super(
         sku: '',
         version: 0,
         ordinal: 0,
         createdDate: null,
         lastModifiedDate: null,
         createdBy: '',
         lastModifiedBy: '',
       );

  factory Payload.initial() {
    return Payload(
      row: 0,
      value: '',
      script: Identifier.initial(),
      text: Identifier.initial(),
      content: Identifier.initial(),
      language: Identifier.initial(),
      word: Identifier.initial(),
      sounds: [],
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
