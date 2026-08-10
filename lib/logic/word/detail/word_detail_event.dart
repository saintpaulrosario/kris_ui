part of 'word_detail_bloc.dart';

@immutable
class WordDetailEvent {
  final int page;
  final int size;
  final List<String>? scripts;
  final List<String>? dialects;
  final List<String>? languages;

  const WordDetailEvent({
    required this.page,
    required this.size,
    this.scripts,
    this.dialects,
    this.languages,
  });
}
