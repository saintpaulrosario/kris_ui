part of 'word_text_bloc.dart';

class WordTextEvent {}

class WordTextEventFetchAll extends WordTextEvent {
  final int pageSize;
  final int pageNumber;

  WordTextEventFetchAll({required this.pageSize, required this.pageNumber});
}

class WordTextEventRetrieveByIdentifier extends WordTextEvent {
  final Identifier identifier;

  WordTextEventRetrieveByIdentifier({required this.identifier});
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
