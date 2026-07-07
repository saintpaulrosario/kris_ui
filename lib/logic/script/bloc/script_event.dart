part of 'script_bloc.dart';

class ScriptEvent {}

class RetrieveScriptsEvent extends ScriptEvent {}

class ScriptsEventSelected extends ScriptEvent {
  final Word selection;
  final bool select;

  ScriptsEventSelected({required this.selection, required this.select});
}

class ScriptEventRetrieveByOrdinal extends ScriptEvent {
  final int ordinal;

  ScriptEventRetrieveByOrdinal({required this.ordinal});
}

class ScriptEventRetrieveBySku extends ScriptEvent {
  final String sku;

  ScriptEventRetrieveBySku({required this.sku});
}
