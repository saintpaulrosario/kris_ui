part of 'script_bloc.dart';

class ScriptEvent {}

class RetrieveScriptsEvent extends ScriptEvent {}

class SelectScriptsEvent extends ScriptEvent {
  final List<Script> selection;

  SelectScriptsEvent({required this.selection});
}
