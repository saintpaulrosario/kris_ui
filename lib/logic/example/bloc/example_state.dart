part of 'example_bloc.dart';

class ExampleState extends BaseState<Example> {
  ExampleState({
    required super.errors,
    required super.fetching,
    required super.data,
  });
  factory ExampleState.initial() {
    return ExampleState(errors: {}, fetching: {}, data: {});
  }

  @override
  ExampleState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, Example>? data,
  }) {
    return ExampleState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
    );
  }
}
