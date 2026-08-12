import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/medium.dart';

import 'account.dart';

part 'word_image.g.dart';

@JsonSerializable(
  includeIfNull: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class WordImage extends Medium {
  WordImage({
    required super.content,
    required super.contentType,
    required super.size,
    required super.description,
    required super.tags,
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
  });

  factory WordImage.initial() {
    return WordImage(
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
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
    );
  }

  factory WordImage.fromJson(Map<String, dynamic> json) =>
      _$WordImageFromJson(json);
}
