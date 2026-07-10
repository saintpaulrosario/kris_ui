part of 'word_bloc.dart';

class WordState extends BaseState<Word> {
  final PageResult page;
  WordState({
    required super.errors,
    required super.fetching,
    required super.data,
    required this.page,
  });

  factory WordState.initial() {
    return WordState(
      errors: {},
      fetching: {},
      data: {},
      page: PageResult.initial(),
    );
  }

  @override
  WordState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, Word>? data,
    PageResult? page,
  }) {
    return WordState(
      errors: errors ?? Map.from(this.errors),
      fetching: fetching ?? Set.from(this.fetching),
      data: data ?? Map.from(this.data),
      page: page ?? this.page,
    );
  }
}
