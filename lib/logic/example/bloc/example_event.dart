part of 'example_bloc.dart';

sealed class ExampleEvent {}

sealed class ExampleEventFetchBySku extends ExampleEvent {
  final String sku;

  ExampleEventFetchBySku({required this.sku});
}
