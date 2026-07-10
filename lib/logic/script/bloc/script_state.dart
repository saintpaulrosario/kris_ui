part of 'script_bloc.dart';

class ScriptState extends BaseState<Script> {
  ScriptState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory ScriptState.initial() {
    return ScriptState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, Script>(),
      selections: BuiltSet<Script>(),
    );
  }

  @override
  ScriptState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, Script>? data,
    BuiltSet<Script>? selections,
  }) {
    return ScriptState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
