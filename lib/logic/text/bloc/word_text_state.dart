part of 'word_text_bloc.dart';

class WordTextState extends BaseState {
  final Map<String, WordText> texts;

  WordTextState({required this.texts}) : super(errors: {}, fetching: {});

  factory WordTextState.initial() {
    return WordTextState(texts: {});
  }

  @override
  WordTextState copyWith({
    Map<String, WordText>? texts,
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
  }) {
    return WordTextState(texts: texts ?? this.texts);
  }
}
