part of 'word_bloc.dart';

class WordState extends BaseState<Word> {
  WordState({
    required super.errors,
    required super.fetching,
    required super.data,
  });
  factory WordState.initial() {
    return WordState(errors: {}, fetching: {}, data: {});
  }

  @override
  WordState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, Word>? data,
  }) {
    return WordState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
    );
  }
}
