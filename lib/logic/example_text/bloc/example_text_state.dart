part of 'example_text_bloc.dart';

class ExampleTextState extends BaseState<ExampleText> {
  ExampleTextState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory ExampleTextState.initial() {
    return ExampleTextState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, ExampleText>(),
      selections: BuiltSet<ExampleText>(),
    );
  }

  @override
  ExampleTextState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, ExampleText>? data,
    BuiltSet<ExampleText>? selections,
  }) {
    return ExampleTextState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
