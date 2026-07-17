part of 'content_bloc.dart';

class ContentEvent {}

class ContentEventRetriveByTextSku extends ContentEvent {
  final String textSku;

  ContentEventRetriveByTextSku(this.textSku);
}

class ContentEventRetriveByIdentifier extends ContentEvent {
  final Identifier identifier;

  ContentEventRetriveByIdentifier({required this.identifier});
}

class ContentEventAdd extends ContentEvent {
  final List<Identifier> identifiers;

  ContentEventAdd(this.identifiers);
}
