part of 'word_bloc.dart';

class WordState extends BaseState<Word> {
  final PageResult<Word> page;

  WordState({
    required super.errors,
    required super.fetching,
    required super.data,
    required this.page,
    required super.selections,
  });

  factory WordState.initial() {
    return WordState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, Word>(),
      page: PageResult.initial(),
      selections: BuiltSet<Word>(),
    );
  }

  @override
  WordState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, Word>? data,
    BuiltSet<Word>? selections,
    PageResult<Word>? page,
  }) {
    return WordState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      page: page ?? this.page,
      selections: selections ?? this.selections,
    );
  }
}
