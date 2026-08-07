import 'field_validator.dart';

class Password extends FieldValidator<String> {
  const Password(super.value);

  @override
  String? get error {
    if (value.length < 6) return 'Password too short';
    return null;
  }
}
