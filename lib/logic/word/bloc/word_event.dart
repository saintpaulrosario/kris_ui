part of 'word_bloc.dart';

class WordEvent {}

class RetrieveWordsEvent extends WordEvent {
  final int pageNumber;
  final int pageSize;

  RetrieveWordsEvent({required this.pageNumber, required this.pageSize});
}

class RetrieveWordBySkuEvent extends WordEvent {
  final String sku;
  RetrieveWordBySkuEvent({required this.sku});
}

class WordEventAdd extends WordEvent {
  final Word word;

  WordEventAdd({required this.word});
}
