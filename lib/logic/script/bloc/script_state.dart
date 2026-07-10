//part of 'script_bloc.dart';

part of 'script_bloc.dart';

class ScriptState extends BaseState<Script> {
  final Set<Word> selections;

  ScriptState({
    required super.errors,
    required super.fetching,
    required super.data,
    required this.selections,
  });
  factory ScriptState.initial() {
    return ScriptState(errors: {}, fetching: {}, data: {}, selections: {});
  }

  @override
  ScriptState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, Script>? data,
    final Set<Word>? selections,
  }) {
    return ScriptState(errors: {}, fetching: {}, data: {}, selections: {});
  }
}
