part of 'example_content_bloc.dart';

class ExampleContentEvent {}

class ExampleContentEventFetchByIdentifier extends ExampleContentEvent {
  final Identifier identifier;

  ExampleContentEventFetchByIdentifier({required this.identifier});
}
