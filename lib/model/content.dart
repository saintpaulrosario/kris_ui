import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/account.dart';
import 'package:kris/model/payload.dart';

import 'identifier.dart';

part 'content.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Content extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> languages;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> payloads;

  const Content({
    required super.sku,
    required super.version,
    required super.ordinal,
    required this.languages,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required this.payloads,
  });

  factory Content.initial() {
    return Content(
      sku: '',
      version: 0,
      ordinal: -1,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      languages: [],
      payloads: [],
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Content && other.sku == sku && other.ordinal == ordinal;
  }

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
