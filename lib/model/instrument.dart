import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/identifier.dart';

part 'instrument.g.dart';

@JsonSerializable(
  includeIfNull: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Instrument extends Identifier {
  final String payload;
  final String contentType;
  final int size;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: <String>[])
  final List<String> tags;

  Instrument({
    required this.payload,
    required this.contentType,
    required this.size,
    required this.description,
    required this.tags,
    required super.sku,
    required super.version,
    required super.row,
    required super.ordinal,
  });

  factory Instrument.initial() {
    return Instrument(
      payload: '',
      contentType: '',
      size: 0,
      description: '',
      tags: [],
      sku: '',
      version: 0,
      row: 0,
      ordinal: 0,
    );
  }

  factory Instrument.fromJson(Map<String, dynamic> json) =>
      _$InstrumentFromJson(json);

  Map<String, dynamic> toJson() => _$InstrumentToJson(this);
}
