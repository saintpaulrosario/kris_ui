part of 'word_bloc.dart';

class WordState extends BaseState {
  final Map<String, Word> words;

  WordState({required this.words}) : super(errors: {}, fetching: {});

  factory WordState.initial() {
    return WordState(words: {});
  }

  @override
  WordState copyWith({
    Map<String, Word>? words,
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
  }) {
    return WordState(words: words ?? this.words);
  }
}
