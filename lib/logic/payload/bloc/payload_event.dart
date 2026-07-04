part of 'payload_bloc.dart';

@immutable
class PayloadEvent {}

class PayloadEventRetrieveBySku extends PayloadEvent {
  final String sku;
  PayloadEventRetrieveBySku(this.sku);
}
