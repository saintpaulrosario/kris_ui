part of 'example_content_bloc.dart';

class ExampleContentState extends BaseState<ExampleContent> {
  ExampleContentState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory ExampleContentState.initial() {
    return ExampleContentState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, ExampleContent>(),
      selections: BuiltSet<ExampleContent>(),
    );
  }

  @override
  ExampleContentState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, ExampleContent>? data,
    BuiltSet<ExampleContent>? selections,
  }) {
    return ExampleContentState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
