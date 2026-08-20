import 'package:built_collection/built_collection.dart';
import 'package:kris/model/identifier.dart';

import '../response/error_response.dart';
import '../response/page_result.dart';

class BaseState<W, T, C, P, S> {
  final BuiltMap<String, ErrorResponse> errors;
  final BuiltSet<String> fetching;
  final BuiltMap<int, PageResult<W>> pages;
  final BuiltMap<String, W> data;
  final BuiltMap<String, T> texts;
  final BuiltMap<String, C> contents;
  final BuiltMap<String, P> payloads;
  final BuiltMap<String, S> traits;
  final BuiltSet<Identifier> selections;

  final int pageNumber;
  final int pageSize;

  BaseState({
    required this.errors,
    required this.fetching,
    required this.data,
    required this.pages,
    required this.texts,
    required this.contents,
    required this.payloads,
    required this.pageNumber,
    required this.pageSize,
    required this.selections,
    required this.traits,
  });

  factory BaseState.initial() {
    return BaseState<W, T, C, P, S>(
      errors: BuiltMap<String, ErrorResponse>(),
      data: BuiltMap<String, W>(),
      fetching: BuiltSet<String>(),
      pages: BuiltMap<int, PageResult<W>>(),
      texts: BuiltMap<String, T>(),
      contents: BuiltMap<String, C>(),
      payloads: BuiltMap<String, P>(),
      pageNumber: 0,
      pageSize: 10,
      selections: BuiltSet<Identifier>(),
      traits: BuiltMap<String, S>(),
    );
  }

  BaseState<W, T, C, P, S> copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltMap<String, W>? data,
    BuiltSet<String>? fetching,
    BuiltSet<Identifier>? selections,
    BuiltMap<int, PageResult<W>>? pages,
    BuiltMap<String, T>? texts,
    BuiltMap<String, C>? contents,
    BuiltMap<String, P>? payloads,
    BuiltMap<String, S>? traits,
    int? pageNumber,
    int? pageSize,
  }) {
    return BaseState<W, T, C, P, S>(
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
    );
  }
}
