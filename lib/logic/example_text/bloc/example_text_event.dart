part of 'example_text_bloc.dart';

class ExampleTextEvent {}

class ExampleTextEventFetchByIdentifier extends ExampleTextEvent {
  final Identifier identifier;

  ExampleTextEventFetchByIdentifier({required this.identifier});
}
