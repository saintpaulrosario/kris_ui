part of 'language_bloc.dart';

class LanguageEvent {}

class LanguageEventFetchAll extends LanguageEvent {}

class LanguageEventFetchBySku extends LanguageEvent {
  final String sku;

  LanguageEventFetchBySku({required this.sku});
}
