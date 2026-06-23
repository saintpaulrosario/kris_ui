part of 'word_text_bloc.dart';

class WordTextEvent {}

class WordTextEventRetrieveBySku extends WordTextEvent {
  final String sku;

  WordTextEventRetrieveBySku({required this.sku});
}
