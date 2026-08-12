import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/account.dart';
import 'package:kris/model/identifier.dart';

import 'text.dart';

part 'word.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Word extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Text> texts;
  final List<Identifier> images;

  const Word({
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.sku,
    required super.version,
    required super.ordinal,
    required this.texts,
    required this.images,
  });

  factory Word.initial() {
    return Word(
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      sku: '',
      version: 0,
      ordinal: 0,
      texts: [],
      images: [],
    );
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    return _$WordFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$WordToJson(this);
}
