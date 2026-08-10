part of 'word_detail_bloc.dart';

class WordDetailState {
  final BuiltMap<String, ErrorResponse> errors;
  final BuiltSet<String> fetching;
  final BuiltMap<int, PageResult<WordDetail>> pages;
  final BuiltMap<String, WordDetail> data;
  final BuiltSet<WordDetail> selections;

  final int pageNumber;
  final int pageSize;

  WordDetailState({
    required this.errors,
    required this.fetching,
    required this.data,
    required this.pages,
    required this.pageNumber,
    required this.pageSize,
    required this.selections,
  });

  factory WordDetailState.initial() {
    return WordDetailState(
      errors: BuiltMap<String, ErrorResponse>(),
      data: BuiltMap<String, WordDetail>(),
      fetching: BuiltSet<String>(),
      pages: BuiltMap<int, PageResult<WordDetail>>(),
      pageNumber: 0,
      pageSize: 10,
      selections: BuiltSet<WordDetail>(),
    );
  }

  WordDetailState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltMap<String, WordDetail>? data,
    BuiltSet<String>? fetching,
    BuiltSet<WordDetail>? selections,
    BuiltMap<int, PageResult<WordDetail>>? pages,
    int? pageNumber,
    int? pageSize,
  }) {
    return WordDetailState(
      errors: errors ?? this.errors,
      data: data ?? this.data,
      fetching: fetching ?? this.fetching,
      pages: pages ?? this.pages,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      selections: selections ?? this.selections,
    );
  }
}
