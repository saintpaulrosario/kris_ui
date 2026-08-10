import 'package:json_annotation/json_annotation.dart';

import 'identifier.dart';

part 'word_detail.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class WordDetail {
  @JsonKey(disallowNullValue: false)
  final Identifier word;
  final List<WordDetail> details;
  final List<Identifier> images;

  const WordDetail({
    required this.word,
    required this.images,
    required this.details,
  });

  factory WordDetail.initial() {
    return WordDetail(word: Identifier.initial(), images: [], details: []);
  }

  @override
  int get hashCode => Object.hash(word.sku, word.sku);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WordDetail && other.word.sku == word.sku;
  }

  factory WordDetail.fromJson(Map<String, dynamic> json) =>
      _$WordDetailFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WordDetailToJson(this);
}
