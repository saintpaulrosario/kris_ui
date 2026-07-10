part of 'word_bloc.dart';

class WordEvent {}

class RetrieveWordsEvent extends WordEvent {
  final int page;
  final int size;

  RetrieveWordsEvent({required this.page, required this.size});
}

class RetrieveWordBySkuEvent extends WordEvent {
  final String sku;
  RetrieveWordBySkuEvent({required this.sku});
}

class WordEventAdd extends WordEvent {
  final Word word;

  WordEventAdd({required this.word});
}
