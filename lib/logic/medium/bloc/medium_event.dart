part of 'medium_bloc.dart';

class MediumEvent {}

class MediumEventFetch extends MediumEvent {
  final String sku;

  MediumEventFetch({required this.sku});
}

class MediumEventFetchIdentifiers extends MediumEvent {
  final List<Identifier> identifiers;

  MediumEventFetchIdentifiers({required this.identifiers});
}

class MediumEventSelected extends MediumEvent {
  final Medium medium;

  MediumEventSelected({required this.medium});
}
