import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/identifier.dart';
import '../../model/word.dart';

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
  final List<Identifier> words;
  const Example({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.texts,
    required super.contents,
    required super.images,
    required super.payloads,
    required this.words,
  });

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
