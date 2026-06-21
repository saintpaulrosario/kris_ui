part of 'word_bloc.dart';

class WordState extends BaseState {
  final List<Word>? words;

  WordState({
    required this.words,
    required super.fetching,
    required super.success,
    required super.message,
    required super.error,
  });

  factory WordState.initial() {
    return WordState(
      words: [],
      fetching: false,
      success: false,
      message: '',
      error: ErrorResponse.initial(),
    );
  }

  @override
  WordState copyWith({
    ErrorResponse? error,
    bool? success,
    String? message,
    int? code,
    bool? fetching,
    List<Word>? words,
  }) {
    return WordState(
      words: words ?? this.words,
      fetching: fetching ?? this.fetching,
      success: success ?? this.success,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}
