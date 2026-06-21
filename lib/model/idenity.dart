import 'package:json_annotation/json_annotation.dart';

import 'audit.dart';

part 'idenity.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Identity extends Audit {
  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String? sku;

  final int? version;

  @JsonKey(disallowNullValue: false, defaultValue: -1)
  final int? row;

  final int? ordinal;

  Identity({
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

  factory Identity.initial() {
    return Identity(sku: "", version: 0, row: -1, ordinal: -1);
  }

  factory Identity.fromJson(Map<String, dynamic> json) =>
      _$IdentityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IdentityToJson(this);
}
