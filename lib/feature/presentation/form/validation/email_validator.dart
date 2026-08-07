import 'field_validator.dart';

class EmailValidator extends FieldValidator<String> {
  const EmailValidator(super.value);

  @override
  String? get error {
    if (value.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) return 'Invalid email format';
    return null;
  }
}
