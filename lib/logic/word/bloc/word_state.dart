part of 'word_bloc.dart';

class WordState extends BaseState {
  final List<Word> words;
  final BehaviorSubject selection;

  WordState({
    required this.words,
    required super.fetching,
    required super.success,
    required super.message,
    required super.error,
    required this.selection,
  });

  factory WordState.initial() {
    return WordState(
      words: [],
      fetching: false,
      success: false,
      message: '',
      error: ErrorResponse.initial(),
      selection: BehaviorSubject<Word?>(),
    );
  }

  @override
  WordState copyWith({
    ErrorResponse? error,
    bool? success,
    String? message,
    bool? fetching,
    List<Word>? words,
    BehaviorSubject<Word?>? selection,
    bool? failure,
  }) {
    return WordState(
      words: words ?? this.words,
      fetching: fetching ?? this.fetching,
      success: success ?? this.success,
      message: message ?? this.message,
      error: error ?? this.error,
      selection: selection ?? this.selection,
    );
  }
}
