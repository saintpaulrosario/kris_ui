part of 'word_bloc.dart';

class WordEvent {}

class RetrieveWordsEvent extends WordEvent {}

class RetrieveWordBySkuEvent extends WordEvent {
  final String sku;
  RetrieveWordBySkuEvent({required this.sku});
}
