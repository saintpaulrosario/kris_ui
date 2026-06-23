part of 'word_text_bloc.dart';

class WordTextState extends BaseState {
  final List<WordText> texts;
  final WordText selection;

  WordTextState({required this.texts, required this.selection})
    : super(
        fetching: false,
        success: false,
        message: '',
        error: ErrorResponse.initial(),
      );

  factory WordTextState.initial() {
    return WordTextState(texts: [], selection: WordText.initial());
  }

  WordTextState copyWith({
    ErrorResponse? error,
    bool? success,
    String? message,
    int? code,
    bool? fetching,
    List<WordText>? texts,
    WordText? selection,
    bool? failure,
  }) {
    return WordTextState(
      texts: texts ?? this.texts,
      selection: selection ?? this.selection,
    );
  }
}
