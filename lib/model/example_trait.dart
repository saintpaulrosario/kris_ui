import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/account.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/trait.dart';

part 'example_trait.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: true,
  disallowUnrecognizedKeys: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class ExampleTrait extends Trait {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> definitions;

  const ExampleTrait({
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.sku,
    required super.version,
    required super.ordinal,
    required this.definitions,
    required super.payload,
    required super.dialect,
  });

  factory ExampleTrait.initial() {
    return ExampleTrait(
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      sku: '',
      version: 0,
      ordinal: 0,
      definitions: [],
      payload: Payload.initial(),
      dialect: Identifier.initial(),
    );
  }

  factory ExampleTrait.fromJson(Map<String, dynamic> json) {
    return _$ExampleTraitFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$ExampleTraitToJson(this);
}
