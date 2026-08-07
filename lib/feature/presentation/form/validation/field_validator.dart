abstract class FieldValidator<T> {
  final T value;

  const FieldValidator(this.value);

  String? get error;

  bool get isValid => error == null;
}
