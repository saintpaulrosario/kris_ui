import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/account.dart';
import 'package:kris/model/word.dart';

import 'identifier.dart';

part 'definition.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Definition extends Word {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> traits;
  const Definition({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.texts,
    required this.traits,
    //required this.examples,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
  });

  factory Definition.initial() {
    return Definition(
      sku: '',
      version: 0,
      ordinal: 0,
      texts: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      traits: [],
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Definition && other.sku == sku && other.ordinal == ordinal;
  }

  factory Definition.fromJson(Map<String, dynamic> json) =>
      _$DefinitionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DefinitionToJson(this);
}
