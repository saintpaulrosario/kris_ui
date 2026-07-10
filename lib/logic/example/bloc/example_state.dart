part of 'example_bloc.dart';

class ExampleState extends BaseState<Example> {
  ExampleState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory ExampleState.initial() {
    return ExampleState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, Example>(),
      selections: BuiltSet<Example>(),
    );
  }

  @override
  ExampleState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, Example>? data,
    BuiltSet<Example>? selections,
  }) {
    return ExampleState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
