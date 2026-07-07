part of 'dialect_bloc.dart';

class DialectEvent {}

class DialectEventFetchAll extends DialectEvent {}

class DialectEventFetchBySku extends DialectEvent {
  final String sku;

  DialectEventFetchBySku({required this.sku});
}
