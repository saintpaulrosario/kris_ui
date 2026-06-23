part of 'word_text_bloc.dart';

class WordTextEvent {}

class WordTextEventRetrieveBySku extends WordTextEvent {
  final String sku;

  WordTextEventRetrieveBySku({required this.sku});
}

class WordTextEventRetrieveByWordSku extends WordTextEvent {
  final String sku;

  WordTextEventRetrieveByWordSku({required this.sku});
}
