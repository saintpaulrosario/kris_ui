import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/account.dart';
import 'package:kris/model/word.dart';

import 'identifier.dart';

part 'example.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Example extends Word {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> traits;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> images;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> translations;
  const Example({
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
    required this.images,
    required super.rows,
    required this.translations,
  });

  factory Example.initial() {
    return Example(
      sku: '',
      version: 0,
      ordinal: 0,
      texts: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      traits: [],
      images: [],
      rows: [],
      translations: [],
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Example && other.sku == sku && other.ordinal == ordinal;
  }

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
