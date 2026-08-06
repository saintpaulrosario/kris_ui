part of 'dialect_bloc.dart';

class DialectState
    extends
        BaseState<
          Dialect,
          TranslationText,
          TranslationContent,
          TranslationPayload
        > {
  DialectState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.pages,
    required super.texts,
    required super.contents,
    required super.payloads,
    required super.pageNumber,
    required super.pageSize,
    required super.selections,
  });

  factory DialectState.initial() {
    return DialectState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),

      data: BuiltMap<String, Dialect>(),
      pages: BuiltMap<int, PageResult<Dialect>>(),

      texts: BuiltMap<String, TranslationText>(),
      contents: BuiltMap<String, TranslationContent>(),
      payloads: BuiltMap<String, TranslationPayload>(),

      pageNumber: 0,
      pageSize: 10,
      selections: BuiltSet<String>(),
    );
  }

  @override
  DialectState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltMap<String, Dialect>? data,
    BuiltSet<String>? fetching,
    BuiltSet<String>? selections,
    BuiltMap<int, PageResult<Dialect>>? pages,
    BuiltMap<String, TranslationText>? texts,
    BuiltMap<String, TranslationContent>? contents,
    BuiltMap<String, TranslationPayload>? payloads,
    int? pageNumber,
    int? pageSize,
  }) {
    return DialectState(
      errors: errors ?? this.errors,
      data: data ?? this.data,
      fetching: fetching ?? this.fetching,
      selections: selections ?? this.selections,
      pages: pages ?? this.pages,
      texts: texts ?? this.texts,
      contents: contents ?? this.contents,
      payloads: payloads ?? this.payloads,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
