import 'package:json_annotation/json_annotation.dart';

part 'idenity.g.dart';

@JsonSerializable(
  nullable: true,
  includeIfNull: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Identity {
  final String? sku;
  final int? version;
  final int? row;
  final int? ordinal;

  Identity({
    required this.sku,
    required this.version,
    required this.row,
    required this.ordinal,
  });

  factory Identity.initial() {
    return Identity(sku: "", version: 0, row: -1, ordinal: -1);
  }

  factory Identity.fromJson(Map<String, dynamic> json) =>
      _$IdentityFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityToJson(this);
}
