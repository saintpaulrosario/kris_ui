import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/word.dart';

import '../../model/identifier.dart';

part 'example.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Example extends Word {
  Example({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.type,
    required super.texts,
    required super.contents,
    required super.images,
    required super.payloads,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.maya,
  });

  factory Example.initial() {
    return Example(
      sku: '',
      version: 0,
      ordinal: -1,
      texts: [],
      contents: [],
      images: [],
      payloads: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      maya: [],
      type: '',
    );
  }

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
