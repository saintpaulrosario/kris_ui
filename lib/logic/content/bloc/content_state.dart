part of 'content_bloc.dart';

class ContentState extends BaseState<Content> {
  ContentState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory ContentState.initial() {
    return ContentState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, Content>(),
      selections: BuiltSet<Content>(),
    );
  }

  @override
  ContentState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, Content>? data,
    BuiltSet<Content>? selections,
  }) {
    return ContentState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
