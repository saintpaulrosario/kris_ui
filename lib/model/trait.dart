import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/account.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';

part 'trait.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: true,
  disallowUnrecognizedKeys: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Trait extends Identifier {
  @JsonKey(disallowNullValue: false)
  final Identifier payload;

  @JsonKey(disallowNullValue: false)
  final Identifier dialect;

  @JsonKey(disallowNullValue: false)
  final Identifier language;

  @JsonKey(disallowNullValue: false, defaultValue: 0)
  final int row;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> audios;

  const Trait({
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.sku,
    required super.version,
    required super.ordinal,
    required this.payload,
    required this.dialect,
    required this.audios,
    required this.language,
    required this.row,
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
      payload: Payload.initial(),
      dialect: Identifier.initial(),
      audios: [],
      language: Identifier.initial(),
      row: 0,
    );
  }

  factory Trait.fromJson(Map<String, dynamic> json) {
    return _$TraitFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$TraitToJson(this);
}
