import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/identifier.dart';

part 'instruction.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Instruction extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> images;

  const Instruction({
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required this.images,
    required super.sku,
    required super.version,
    required super.ordinal,
  });

  factory Instruction.initial() {
    return Instruction(
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      images: [],
      sku: '',
      version: 0,
      ordinal: 0,
    );
  }

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return _$InstructionFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$InstructionToJson(this);
}
