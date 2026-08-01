part of 'word_bloc.dart';

class WordState extends BaseState<Word> {
  final BuiltMap<int, PageResult<Word>> pages;
  final BuiltMap<String, WordText> texts;
  final BuiltMap<String, WordContent> contents;
  final BuiltMap<String, WordPayload> payloads;

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

    required this.texts,
    required this.contents,
    required this.payloads,
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

      texts: BuiltMap<String, WordText>(),
      contents: BuiltMap<String, WordContent>(),
      payloads: BuiltMap<String, WordPayload>(),
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
    String? type,
    BuiltMap<String, WordText>? texts,
    BuiltMap<String, WordContent>? contents,
    BuiltMap<String, WordPayload>? payloads,
  }) {
    return WordState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      pages: pages ?? this.pages,
      selections: selections ?? this.selections,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      texts: texts ?? this.texts,
      contents: contents ?? this.contents,
      payloads: payloads ?? this.payloads,
    );
  }
}
