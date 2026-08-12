import 'package:built_collection/built_collection.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';

import '../response/error_response.dart';
import '../response/page_result.dart';

class BaseState<W> {
  final BuiltMap<String, ErrorResponse> errors;
  final BuiltSet<String> fetching;
  final BuiltMap<int, PageResult<W>> pages;
  final BuiltMap<String, W> data;
  final BuiltMap<String, Text> texts;
  final BuiltMap<String, Content> contents;
  final BuiltMap<String, Payload> payloads;
  final BuiltSet<String> selections;

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
  });

  factory BaseState.initial() {
    return BaseState(
      errors: BuiltMap<String, ErrorResponse>(),
      data: BuiltMap<String, W>(),
      fetching: BuiltSet<String>(),
      pages: BuiltMap<int, PageResult<W>>(),
      texts: BuiltMap<String, Text>(),
      contents: BuiltMap<String, Content>(),
      payloads: BuiltMap<String, Payload>(),
      pageNumber: 0,
      pageSize: 10,
      selections: BuiltSet<String>(),
    );
  }

  BaseState<W> copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltMap<String, W>? data,
    BuiltSet<String>? fetching,
    BuiltSet<String>? selections,
    BuiltMap<int, PageResult<W>>? pages,
    BuiltMap<String, Text>? texts,
    BuiltMap<String, Content>? contents,
    BuiltMap<String, Payload>? payloads,
    int? pageNumber,
    int? pageSize,
  }) {
    return BaseState<W>(
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
