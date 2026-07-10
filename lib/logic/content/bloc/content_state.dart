part of 'content_bloc.dart';

class ContentState extends BaseState<Content> {
  ContentState({
    required super.errors,
    required super.fetching,
    required super.data,
  });
  factory ContentState.initial() {
    return ContentState(errors: {}, fetching: {}, data: {});
  }

  @override
  ContentState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, Content>? data,
  }) {
    return ContentState(errors: {}, fetching: {}, data: {});
  }
}
