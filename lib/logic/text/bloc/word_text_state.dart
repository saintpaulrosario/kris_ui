part of 'word_text_bloc.dart';

class WordTextState extends BaseState {
  final WordText text;

  WordTextState({required this.text})
    : super(
        failure: false,
        fetching: false,
        success: false,
        message: '',
        error: ErrorResponse.initial(),
      );

  factory WordTextState.initial() {
    return WordTextState(text: WordText.initial());
  }

  WordTextState copyWith({
    ErrorResponse? error,
    bool? success,
    String? message,
    int? code,
    bool? fetching,
    WordText? text,
    bool? failure,
  }) {
    return WordTextState(text: text ?? this.text);
  }
}
