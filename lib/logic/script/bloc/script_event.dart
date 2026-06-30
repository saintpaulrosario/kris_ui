part of 'script_bloc.dart';

class ScriptEvent {}

class RetrieveScriptsEvent extends ScriptEvent {}

class SelectScriptsEvent extends ScriptEvent {
  final List<Script> selection;

  SelectScriptsEvent({required this.selection});
}

class ScriptEventRetrieveByOrdinal extends ScriptEvent {
  final int ordinal;

  ScriptEventRetrieveByOrdinal({required this.ordinal});
}

class ScriptEventRetrieveBySku extends ScriptEvent {
  final String sku;

  ScriptEventRetrieveBySku({required this.sku});
}
