part of 'word_bloc.dart';

class WordEvent {}

class WordEventFetch extends WordEvent {
  final int pageNumber;
  final int pageSize;

  WordEventFetch({required this.pageNumber, required this.pageSize});
}

class RetrieveWordsEventFetchBySku extends WordEvent {
  final Identifier identifier;
  RetrieveWordsEventFetchBySku({required this.identifier});
}

class RetrieveWordsEventFetchTextBySku extends WordEvent {
  final Identifier identifier;
  RetrieveWordsEventFetchTextBySku({required this.identifier});
}

class RetrieveWordsEventFetchContentBySku extends WordEvent {
  final Identifier identifier;
  RetrieveWordsEventFetchContentBySku({required this.identifier});
}

class RetrieveWordsEventFetchPayloadBySku extends WordEvent {
  final Identifier identifier;
  RetrieveWordsEventFetchPayloadBySku({required this.identifier});
}

class WordEventAdd extends WordEvent {
  final Word word;

  WordEventAdd({required this.word});
}
