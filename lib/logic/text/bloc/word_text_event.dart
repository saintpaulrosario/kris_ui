part of 'word_text_bloc.dart';

class WordTextEvent {}

class WordTextEventRetrieveBySku extends WordTextEvent {
  final String sku;

  WordTextEventRetrieveBySku({required this.sku});
}

class WordTextEventRetrieveByTextAndWordSku extends WordTextEvent {
  final String textSku;
  final String wordSku;

  WordTextEventRetrieveByTextAndWordSku({
    required this.textSku,
    required this.wordSku,
  });
}

class WordTextEventRetrieveByWordSku extends WordTextEvent {
  final String wordSku;

  WordTextEventRetrieveByWordSku({required this.wordSku});
}

class WordTextEventAdd extends WordTextEvent {
  final Identifier identifier;

  WordTextEventAdd({required this.identifier});
}
