part of 'word_text_bloc.dart';

class WordTextState extends BaseState {
  final ReplaySubject<List<WordText>> texts;
  final WordText selection;

  WordTextState({required this.texts, required this.selection})
    : super(
        fetching: false,
        success: true,
        message: '',
        error: ErrorResponse.initial(),
      );

  factory WordTextState.initial() {
    return WordTextState(
      texts: ReplaySubject<List<WordText>>(),
      selection: WordText.initial(),
    );
  }

  WordTextState copyWith({
    ErrorResponse? error,
    bool? success,
    String? message,
    bool? fetching,
    ReplaySubject<List<WordText>>? texts,
    WordText? selection,
  }) {
    return WordTextState(
      texts: texts ?? this.texts,
      selection: selection ?? this.selection,
    );
  }
}
