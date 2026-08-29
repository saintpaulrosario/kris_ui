import 'package:built_collection/built_collection.dart';

import '../../model/content.dart';
import '../../model/definition.dart';
import '../../model/definition_trait.dart';
import '../../model/identifier.dart';
import '../../model/payload.dart';
import '../../model/text.dart';
import '../../model/word.dart';
import '../../response/error_response.dart';
import '../../response/page_result.dart';
import '../base_state.dart';

class DefinitionState
    extends BaseState<Definition, Text, Content, Payload, DefinitionTrait> {
  final BuiltMap<String, BuiltList<Definition>> wordTraitsDefinitions;
  final BuiltMap<String, Word> word;

  DefinitionState({
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
    required super.traits,
    required this.wordTraitsDefinitions,
    required this.word,
  });

  DefinitionState.initial()
    : wordTraitsDefinitions = BuiltMap<String, BuiltList<Definition>>(),
      word = BuiltMap<String, Word>(),
      super(
        errors: BuiltMap<String, ErrorResponse>(),
        data: BuiltMap<String, Definition>(),
        fetching: BuiltSet<String>(),
        pages: BuiltMap<int, PageResult<Definition>>(),
        texts: BuiltMap<String, Text>(),
        contents: BuiltMap<String, Content>(),
        payloads: BuiltMap<String, Payload>(),
        pageNumber: 0,
        pageSize: 10,
        selections: BuiltSet<Identifier>(),
        traits: BuiltMap<String, DefinitionTrait>(),
      );

  @override
  DefinitionState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltMap<String, Definition>? data,
    BuiltSet<String>? fetching,
    BuiltSet<Identifier>? selections,
    BuiltMap<int, PageResult<Definition>>? pages,
    BuiltMap<String, Text>? texts,
    BuiltMap<String, Content>? contents,
    BuiltMap<String, Payload>? payloads,
    BuiltMap<String, DefinitionTrait>? traits,
    BuiltMap<String, BuiltList<Definition>>? wordTraitsDefinitions,
    BuiltMap<String, Word>? word,
    int? pageNumber,
    int? pageSize,
  }) {
    return DefinitionState(
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
      traits: traits ?? this.traits,
      wordTraitsDefinitions:
          wordTraitsDefinitions ?? this.wordTraitsDefinitions,
      word: word ?? this.word,
    );
  }
}
