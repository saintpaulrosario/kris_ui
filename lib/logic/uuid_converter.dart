import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

class UuidConverter extends JsonConverter<UuidValue, String> {
  const UuidConverter();

  @override
  UuidValue fromJson(String json) {
    return UuidValue.fromString(json);
  }

  @override
  String toJson(UuidValue object) {
    return object.toString();
  }
}
