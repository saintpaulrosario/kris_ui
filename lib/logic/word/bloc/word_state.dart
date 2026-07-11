part of 'word_bloc.dart';

class WordState extends BaseState<Word> {
  final BuiltMap<int, PageResult<Word>> pages;
  final int pageNumber;
  final int pageSize;

  WordState({
    required super.errors,
    required super.fetching,
    required super.data,
    required this.pages,
    required super.selections,
    required this.pageNumber,
    required this.pageSize,
  });

  factory WordState.initial() {
    return WordState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, Word>(),
      pages: BuiltMap<int, PageResult<Word>>(),
      selections: BuiltSet<Word>(),
      pageNumber: 0,
      pageSize: 10,
    );
  }

  @override
  WordState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, Word>? data,
    BuiltSet<Word>? selections,
    BuiltMap<int, PageResult<Word>>? pages,
    int? pageNumber,
    int? pageSize,
  }) {
    return WordState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      pages: pages ?? this.pages,
      selections: selections ?? this.selections,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
