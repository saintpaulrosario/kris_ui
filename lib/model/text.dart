import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/account.dart';
import 'package:kris/model/content.dart';

import 'identifier.dart';

part 'text.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Text extends Identifier {
  @JsonKey(disallowNullValue: false)
  final Identifier script;
  final Identifier word;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> contents;

  const Text({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required this.script,
    required this.word,
    required this.contents,
  });

  factory Text.initial() {
    return Text(
      sku: '',
      version: 0,
      ordinal: 0,

      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      script: Identifier.initial(),
      word: Identifier.initial(),
      contents: [],
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Text && other.sku == sku && other.ordinal == ordinal;
  }

  factory Text.fromJson(Map<String, dynamic> json) => _$TextFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TextToJson(this);
}
