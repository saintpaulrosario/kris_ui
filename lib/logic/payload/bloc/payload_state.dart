part of 'payload_bloc.dart';

@immutable
class PayloadState extends BaseState {
  final Map<String, Payload> payloads;

  PayloadState({required this.payloads}) : super(errors: {}, fetching: {});

  factory PayloadState.initial() {
    return PayloadState(payloads: {});
  }

  @override
  PayloadState copyWith({
    Map<String, Payload>? payloads,
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
  }) {
    return PayloadState(payloads: payloads ?? this.payloads);
  }
}
