part of 'payload_bloc.dart';

@immutable
class PayloadEvent {}

class PayloadEventRetrieveBySku extends PayloadEvent {
  final Identifier identifier;
  PayloadEventRetrieveBySku(this.identifier);
}

class PayloadEventAdd extends PayloadEvent {
  final List<Identifier> identifiers;
  PayloadEventAdd(this.identifiers);
}
