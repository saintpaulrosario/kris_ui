import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/account.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';

part 'trait.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Trait extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> definitions;

  @JsonKey(disallowNullValue: false)
  final Identifier payload;

  const Trait({
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.sku,
    required super.version,
    required super.ordinal,
    required this.definitions,
    required this.payload,
  });

  factory Trait.initial() {
    return Trait(
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      sku: '',
      version: 0,
      ordinal: 0,
      definitions: [],
      payload: Payload.initial(),
    );
  }

  factory Trait.fromJson(Map<String, dynamic> json) {
    return _$TraitFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$TraitToJson(this);
}
