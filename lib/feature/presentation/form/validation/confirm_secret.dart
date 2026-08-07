import 'field_validator.dart';

class ConfirmPassword extends FieldValidator<String> {
  final String original;

  const ConfirmPassword(super.value, this.original);

  @override
  String? get error {
    if (value != original) return 'Passwords do not match';
    return null;
  }
}
