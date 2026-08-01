part of 'script_bloc.dart';

class ScriptEvent {}

sealed class ScriptEventFetchBySku extends ScriptEvent {
  final Identifier identifier;
  ScriptEventFetchBySku({required this.identifier});
}
