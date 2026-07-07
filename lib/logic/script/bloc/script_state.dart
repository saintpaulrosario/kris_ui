//part of 'script_bloc.dart';

part of 'script_bloc.dart';

class ScriptState extends BaseState {
  final Map<String, Script> scripts;
  final Set<Word> selections;

  ScriptState({required this.scripts, required this.selections})
    : super(errors: {}, fetching: {});

  factory ScriptState.initial() {
    return ScriptState(scripts: {}, selections: {});
  }

  @override
  ScriptState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Set<Word>? selections,
    Map<String, Script>? scripts,
  }) {
    return ScriptState(
      scripts: scripts ?? this.scripts,
      selections: selections ?? this.selections,
    );
  }
}
