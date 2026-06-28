part of 'content_bloc.dart';

class ContentState extends BaseState {
  final Map<String, Content> contents;

  ContentState({required this.contents}) : super(errors: {}, fetching: {});

  factory ContentState.initial() {
    return ContentState(contents: {});
  }

  @override
  ContentState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, Content>? contents,
  }) {
    return ContentState(contents: contents ?? this.contents);
  }
}
