part of 'payload_bloc.dart';

@immutable
class PayloadState extends BaseState<Payload> {
  PayloadState({
    required super.errors,
    required super.fetching,
    required super.data,
  });

  factory PayloadState.initial() {
    return PayloadState(errors: {}, fetching: {}, data: {});
  }

  @override
  PayloadState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, Payload>? data,
  }) {
    return PayloadState(
      errors: errors ?? Map.from(this.errors),
      fetching: fetching ?? Set.from(this.fetching),
      data: data ?? Map.from(this.data),
    );
  }
}
