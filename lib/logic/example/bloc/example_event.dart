part of 'example_bloc.dart';

class ExampleEvent {}

class ExampleEventFetchBySku extends ExampleEvent {
  final String sku;

  ExampleEventFetchBySku({required this.sku});
}
