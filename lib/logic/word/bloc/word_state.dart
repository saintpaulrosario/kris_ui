part of 'word_bloc.dart';

class WordState extends BaseState {
  final Map<String, Word> words;
  final Set<String> loading;

  WordState({
    required this.words,
    required this.loading,
    required super.fetching,
    required super.success,
    required super.message,
    required super.error,
  });

  factory WordState.initial() {
    return WordState(
      words: {},
      loading: {},
      fetching: false,
      success: false,
      message: '',
      error: ErrorResponse.initial(),
    );
  }

  @override
  WordState copyWith({
    Map<String, Word>? words,
    Set<String>? loading,
    ErrorResponse? error,
    bool? success,
    String? message,
    bool? fetching,
    bool? failure,
  }) {
    return WordState(
      fetching: fetching ?? this.fetching,
      success: success ?? this.success,
      message: message ?? this.message,
      error: error ?? this.error,
      words: words ?? this.words,
      loading: loading ?? this.loading,
    );
  }
}
