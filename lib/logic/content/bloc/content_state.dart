part of 'content_bloc.dart';

class ContentState extends BaseState {
  final List<Content> contents;
  final Content selection;

  ContentState({
    required this.contents,
    required super.fetching,
    required super.success,
    required super.message,
    required super.error,
    required this.selection,
  });

  factory ContentState.initial() {
    return ContentState(
      contents: [],
      fetching: false,
      success: true,
      message: '',
      error: ErrorResponse.initial(),
      selection: Content.initial(),
    );
  }

  @override
  ContentState copyWith({
    ErrorResponse? error,
    bool? success,
    String? message,
    int? code,
    bool? fetching,
    List<Content>? contents,
    Content? selection,
    bool? failure,
  }) {
    return ContentState(
      contents: contents ?? this.contents,
      fetching: fetching ?? this.fetching,
      success: success ?? this.success,
      message: message ?? this.message,
      error: error ?? this.error,
      selection: selection ?? this.selection,
    );
  }
}
