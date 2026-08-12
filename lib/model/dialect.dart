import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/account.dart';
import 'package:kris/model/word.dart';

import 'identifier.dart';
import 'text.dart';

part 'dialect.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Dialect extends Word {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> languages;
  const Dialect({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.texts,
    required this.languages,
    //required this.examples,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.images,
  });

  factory Dialect.initial() {
    return Dialect(
      sku: '',
      version: 0,
      ordinal: 0,
      texts: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      languages: [],
      images: [],
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Dialect && other.sku == sku && other.ordinal == ordinal;
  }

  factory Dialect.fromJson(Map<String, dynamic> json) =>
      _$DialectFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DialectToJson(this);
}
