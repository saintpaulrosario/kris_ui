part of 'example_payload_bloc.dart';

class ExamplePayloadEvent {}

class ExamplePayloadEventRetriveByIdentifier extends ExamplePayloadEvent {
  final Identifier identifier;

  ExamplePayloadEventRetriveByIdentifier({required this.identifier});
}
