//part of 'script_bloc.dart';

part of 'script_bloc.dart';

class ScriptState extends BaseState {
  final Map<String, Script> scripts;

  ScriptState({required this.scripts}) : super(errors: {}, fetching: {});

  factory ScriptState.initial() {
    return ScriptState(scripts: {});
  }

  @override
  ScriptState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, Script>? scripts,
  }) {
    return ScriptState(scripts: scripts ?? this.scripts);
  }
}
