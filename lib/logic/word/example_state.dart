import 'package:built_collection/built_collection.dart';
import 'package:kris/model/example.dart';
import 'package:kris/model/example_trait.dart';

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

class ExampleState
    extends BaseState<Example, Text, Content, Payload, ExampleTrait> {
  final BuiltMap<String, Example> wordTraits;
  final BuiltMap<String, Word> word;

  ExampleState({
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
    required this.wordTraits,
    required this.word,
  });

  ExampleState.initial()
    : wordTraits = BuiltMap<String, Example>(),
      word = BuiltMap<String, Word>(),
      super(
        errors: BuiltMap<String, ErrorResponse>(),
        data: BuiltMap<String, Example>(),
        fetching: BuiltSet<String>(),
        pages: BuiltMap<int, PageResult<Example>>(),
        texts: BuiltMap<String, Text>(),
        contents: BuiltMap<String, Content>(),
        payloads: BuiltMap<String, Payload>(),
        pageNumber: 0,
        pageSize: 10,
        selections: BuiltSet<Identifier>(),
        traits: BuiltMap<String, ExampleTrait>(),
      );

  @override
  ExampleState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltMap<String, Example>? data,
    BuiltSet<String>? fetching,
    BuiltSet<Identifier>? selections,
    BuiltMap<int, PageResult<Example>>? pages,
    BuiltMap<String, Text>? texts,
    BuiltMap<String, Content>? contents,
    BuiltMap<String, Payload>? payloads,
    BuiltMap<String, ExampleTrait>? traits,
    BuiltMap<String, Example>? wordTraitsDefinitions,
    BuiltMap<String, Word>? word,
    int? pageNumber,
    int? pageSize,
  }) {
    return ExampleState(
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
      wordTraits: wordTraitsDefinitions ?? this.wordTraits,
      word: word ?? this.word,
    );
  }
}
