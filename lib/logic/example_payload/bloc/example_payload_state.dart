part of 'example_payload_bloc.dart';

class ExamplePayloadState extends BaseState<ExamplePayload> {
  ExamplePayloadState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory ExamplePayloadState.initial() {
    return ExamplePayloadState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, ExamplePayload>(),
      selections: BuiltSet<ExamplePayload>(),
    );
  }

  @override
  ExamplePayloadState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, ExamplePayload>? data,
    BuiltSet<ExamplePayload>? selections,
  }) {
    return ExamplePayloadState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
