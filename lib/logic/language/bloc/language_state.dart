part of 'language_bloc.dart';

class LanguageState
    extends
        BaseState<
          Language,
          TranslationText,
          TranslationContent,
          TranslationPayload
        > {
  LanguageState({
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

  factory LanguageState.initial() {
    return LanguageState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),

      data: BuiltMap<String, Language>(),
      pages: BuiltMap<int, PageResult<Language>>(),

      texts: BuiltMap<String, TranslationText>(),
      contents: BuiltMap<String, TranslationContent>(),
      payloads: BuiltMap<String, TranslationPayload>(),

      pageNumber: 0,
      pageSize: 10,
      selections: BuiltSet<String>(),
    );
  }

  @override
  LanguageState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltMap<String, Language>? data,
    BuiltSet<String>? fetching,
    BuiltSet<String>? selections,
    BuiltMap<int, PageResult<Language>>? pages,
    BuiltMap<String, TranslationText>? texts,
    BuiltMap<String, TranslationContent>? contents,
    BuiltMap<String, TranslationPayload>? payloads,
    int? pageNumber,
    int? pageSize,
  }) {
    return LanguageState(
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
