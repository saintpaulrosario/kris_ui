import 'package:json_annotation/json_annotation.dart';

import 'audit.dart';

part 'identifier.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Identifier extends Audit {
  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String sku;

  @JsonKey(disallowNullValue: false, defaultValue: -1)
  final int version;

  @JsonKey(disallowNullValue: false, defaultValue: -1)
  final int row;

  @JsonKey(disallowNullValue: false, defaultValue: -1)
  final int ordinal;

  Identifier({
    required this.sku,
    required this.version,
    required this.row,
    required this.ordinal,
  }) : super(
         createdDate: null,
         lastModifiedDate: null,
         createdBy: '',
         lastModifiedBy: '',
       );

  factory Identifier.initial() {
    return Identifier(sku: "", version: 0, row: -1, ordinal: -1);
  }

  factory Identifier.fromJson(Map<String, dynamic> json) =>
      _$IdentifierFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IdentifierToJson(this);
}
