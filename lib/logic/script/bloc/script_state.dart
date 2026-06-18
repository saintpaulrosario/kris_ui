//part of 'script_bloc.dart';

part of 'script_bloc.dart';

class ScriptState extends BaseState {
  final List<Script>? scripts;

  ScriptState({
    required super.fetching,
    required super.success,
    required super.message,
    required super.error,
    required this.scripts,
  });

  factory ScriptState.initial() {
    return ScriptState(
      success: false,
      message: '',
      fetching: false,
      error: ErrorResponse.initial(),
      scripts: [],
    );
  }

  @override
  ScriptState copyWith({
    ErrorResponse? error,
    bool? success,
    String? message,
    int? code,
    bool? fetching,
    List<Script>? scripts,
  }) {
    return ScriptState(
      error: error ?? this.error,
      fetching: fetching ?? this.fetching,
      success: success ?? this.success,
      message: message ?? this.message,
      scripts: scripts ?? this.scripts,
    );
  }
}
