part of 'word_bloc.dart';

class WordEvent {}

class RetrieveWordsEvent extends WordEvent {
  final int pageNumber;
  final int pageSize;
  final String type;
  final String? maya;

  RetrieveWordsEvent({
    required this.pageNumber,
    required this.pageSize,
    required this.type,
    this.maya,
  });
}

class RetrieveWordBySkuEvent extends WordEvent {
  final Identifier identifier;
  RetrieveWordBySkuEvent({required this.identifier});
}

class WordEventAdd extends WordEvent {
  final Word word;

  WordEventAdd({required this.word});
}
