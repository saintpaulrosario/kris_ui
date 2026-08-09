import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/identifier.dart';

part 'medium.g.dart';

@JsonSerializable(
  includeIfNull: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Medium extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String content;

  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String contentType;

  @JsonKey(disallowNullValue: false, defaultValue: 0)
  final int size;

  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String description;

  @JsonKey(disallowNullValue: false, defaultValue: <String>[])
  final List<String> tags;

  const Medium({
    required this.content,
    required this.contentType,
    required this.size,
    required this.description,
    required this.tags,
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
  });

  factory Medium.initial() {
    return Medium(
      content: '',
      contentType: '',
      size: 0,
      description: '',
      tags: [],
      sku: '',
      version: 0,
      ordinal: 0,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
    );
  }

  factory Medium.fromJson(Map<String, dynamic> json) => _$MediumFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MediumToJson(this);
}
