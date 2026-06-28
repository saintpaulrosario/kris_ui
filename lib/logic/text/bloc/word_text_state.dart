part of 'word_text_bloc.dart';

class WordTextState {
  final Map<String, WordText> texts;
  final Map<String, ErrorResponse> errors;
  final Set<String> loading;

  const WordTextState({
    required this.texts,
    required this.errors,
    required this.loading,
  });

  factory WordTextState.initial() {
    return const WordTextState(texts: {}, errors: {}, loading: {});
  }

  WordTextState copyWith({
    Map<String, WordText>? texts,
    Map<String, ErrorResponse>? errors,
    Set<String>? loading,
  }) {
    return WordTextState(
      texts: texts ?? this.texts,
      errors: errors ?? this.errors,
      loading: loading ?? this.loading,
    );
  }
}
