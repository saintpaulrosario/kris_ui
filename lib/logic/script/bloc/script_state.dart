part of 'script_bloc.dart';

class ScriptState
    extends
        BaseState<
          Script,
          TranslationText,
          TranslationContent,
          TranslationPayload
        > {
  ScriptState({
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

  factory ScriptState.initial() {
    return ScriptState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),

      data: BuiltMap<String, Script>(),
      pages: BuiltMap<int, PageResult<Script>>(),

      texts: BuiltMap<String, TranslationText>(),
      contents: BuiltMap<String, TranslationContent>(),
      payloads: BuiltMap<String, TranslationPayload>(),

      pageNumber: 0,
      pageSize: 10,
      selections: BuiltSet<String>(),
    );
  }

  @override
  ScriptState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltMap<String, Script>? data,
    BuiltSet<String>? fetching,
    BuiltSet<String>? selections,
    BuiltMap<int, PageResult<Script>>? pages,
    BuiltMap<String, TranslationText>? texts,
    BuiltMap<String, TranslationContent>? contents,
    BuiltMap<String, TranslationPayload>? payloads,
    int? pageNumber,
    int? pageSize,
  }) {
    return ScriptState(
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
