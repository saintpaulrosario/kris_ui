part of 'content_bloc.dart';

class ContentEvent {}

class ContentEventRetriveByTextSku extends ContentEvent {
  final String textSku;

  ContentEventRetriveByTextSku(this.textSku);
}
