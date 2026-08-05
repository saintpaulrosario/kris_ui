part of 'translation_bloc.dart';

class TranslationState
    extends
        BaseState<
          Translation,
          TranslationText,
          TranslationContent,
          TranslationPayload
        > {
  TranslationState({
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

  factory TranslationState.initial() {
    return TranslationState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),

      data: BuiltMap<String, Translation>(),
      pages: BuiltMap<int, PageResult<Translation>>(),

      texts: BuiltMap<String, TranslationText>(),
      contents: BuiltMap<String, TranslationContent>(),
      payloads: BuiltMap<String, TranslationPayload>(),

      pageNumber: 0,
      pageSize: 10,
      selections: BuiltSet<String>(),
    );
  }

  @override
  TranslationState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltMap<String, Translation>? data,
    BuiltSet<String>? fetching,
    BuiltSet<String>? selections,
    BuiltMap<int, PageResult<Translation>>? pages,
    BuiltMap<String, TranslationText>? texts,
    BuiltMap<String, TranslationContent>? contents,
    BuiltMap<String, TranslationPayload>? payloads,
    int? pageNumber,
    int? pageSize,
  }) {
    return TranslationState(
      errors: errors ?? this.errors,
      data: data ?? this.data,
      fetching: fetching ?? this.fetching,
      pages: pages ?? this.pages,
      texts: texts ?? this.texts,
      contents: contents ?? this.contents,
      payloads: payloads ?? this.payloads,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      selections: selections ?? this.selections,
    );
  }
}
