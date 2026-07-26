part of 'content_bloc.dart';

class ContentState extends BaseState<Content> {
  final int pageNumber;
  final int pageSize;
  final BuiltMap<int, PageResult<Content>> pages;
  ContentState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
    required this.pageNumber,
    required this.pageSize,
    required this.pages,
  });

  factory ContentState.initial() {
    return ContentState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, Content>(),
      selections: BuiltSet<Content>(),
      pageNumber: 0,
      pageSize: 13,
      pages: BuiltMap<int, PageResult<Content>>(),
    );
  }

  @override
  ContentState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, Content>? data,
    BuiltSet<Content>? selections,
    BuiltMap<int, PageResult<Content>>? pages,
    int? pageNumber,
    int? pageSize,
  }) {
    return ContentState(
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
