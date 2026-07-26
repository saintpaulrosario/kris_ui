part of 'word_text_bloc.dart';

class WordTextState extends BaseState<WordText> {
  final int pageNumber;
  final int pageSize;
  final BuiltMap<int, PageResult<WordText>> pages;
  WordTextState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
    required this.pageNumber,
    required this.pageSize,
    required this.pages,
  });

  factory WordTextState.initial() {
    return WordTextState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, WordText>(),
      selections: BuiltSet<WordText>(),
      pageNumber: 0,
      pageSize: 13,
      pages: BuiltMap<int, PageResult<WordText>>(),
    );
  }

  @override
  WordTextState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, WordText>? data,
    BuiltSet<WordText>? selections,
    BuiltMap<int, PageResult<WordText>>? pages,
    int? pageNumber,
    int? pageSize,
  }) {
    return WordTextState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      pages: pages ?? this.pages,
    );
  }
}
