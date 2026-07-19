part of 'example_bloc.dart';

class ExampleEvent {}

class ExampleEventFetch extends ExampleEvent {
  final Identifier identifier;

  ExampleEventFetch({required this.identifier});
}

class ExampleEventFetchByWord extends ExampleEvent {
  final Identifier identifier;

  ExampleEventFetchByWord({required this.identifier});
}
