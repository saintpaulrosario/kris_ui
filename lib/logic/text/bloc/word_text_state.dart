part of 'word_text_bloc.dart';

class WordTextState extends BaseState<WordText> {
  WordTextState({
    required super.errors,
    required super.fetching,
    required super.data,
  });

  factory WordTextState.initial() {
    return WordTextState(errors: {}, fetching: {}, data: {});
  }

  @override
  WordTextState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, WordText>? data,
  }) {
    return WordTextState(
      errors: errors ?? Map.from(this.errors),
      fetching: fetching ?? Set.from(this.fetching),
      data: data ?? Map.from(this.data),
    );
  }
}
