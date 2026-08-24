import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/account.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/trait.dart';

part 'definition_trait.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: true,
  disallowUnrecognizedKeys: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class DefinitionTrait extends Trait {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> traits;

  @JsonKey(disallowNullValue: false)
  final Identifier? type;

    @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> examples;

    @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> translations;

  const DefinitionTrait({
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.dialect,
    required super.payload,
    required this.traits,
    required this.type,
    required this.examples,
    required this.translations,
    required super.audios,
  });

  factory DefinitionTrait.initial() {
    return DefinitionTrait(
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      sku: '',
      version: 0,
      ordinal: 0,
      payload: Payload.initial(),
      dialect: Identifier.initial(),
      traits: [],
      type: Identifier.initial(),
      examples: [],
      translations: [],
      audios: [],
    );
  }

  factory DefinitionTrait.fromJson(Map<String, dynamic> json) {
    return _$DefinitionTraitFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$DefinitionTraitToJson(this);
}
