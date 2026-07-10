part of 'payload_bloc.dart';

class PayloadState extends BaseState<Payload> {
  PayloadState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory PayloadState.initial() {
    return PayloadState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, Payload>(),
      selections: BuiltSet<Payload>(),
    );
  }

  @override
  PayloadState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, Payload>? data,
    BuiltSet<Payload>? selections,
  }) {
    return PayloadState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
