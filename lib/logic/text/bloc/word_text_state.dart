part of 'word_text_bloc.dart';

class WordTextState extends BaseState<WordText> {
  WordTextState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory WordTextState.initial() {
    return WordTextState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, WordText>(),
      selections: BuiltSet<WordText>(),
    );
  }

  @override
  WordTextState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, WordText>? data,
    BuiltSet<WordText>? selections,
  }) {
    return WordTextState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
