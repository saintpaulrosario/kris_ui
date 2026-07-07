import 'package:bloc/bloc.dart';
import 'package:kris/data/service/script_service.dart';
import 'package:kris/model/identifier.dart';

import 'package:kris/model/script.dart';
import 'package:kris/model/word.dart';

import '../../../model/content.dart';
import '../../../model/error_response.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../content/bloc/content_bloc.dart';
import '../../text/bloc/word_text_bloc.dart';

part 'script_event.dart';
part 'script_state.dart';

// TODO should load data from cache if first load

class ScriptBloc extends Bloc<ScriptEvent, ScriptState> {
  final WordTextBloc _wordTextBloc = getIt<WordTextBloc>();
  final ScriptService _scriptService = getIt<ScriptService>();

  final BehaviorSubject<Script> _scriptSubject;

  ScriptBloc()
    : _scriptSubject = BehaviorSubject<Script>(),
      super(ScriptState.initial()) {
    on<ScriptEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ScriptEventRetrieveBySku>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      fetching.add(event.sku);
      emit(state.copyWith(fetching: fetching));
      await _scriptService.retriveBySku(event.sku).then((result) {
        result.fold((error) {}, (script) {
          Map<String, Script> scripts = Map<String, Script>.from(state.scripts);
          scripts[event.sku] = script;
          emit(state.copyWith(scripts: scripts));
        });
      });
      fetching.remove(event.sku);
      emit(state.copyWith(fetching: fetching));
    });

    on<RetrieveScriptsEvent>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      emit(state.copyWith(fetching: fetching));
      await _scriptService.retriveAll().then((result) {
        result.fold((error) {}, (scriptsList) {
          Map<String, Script> scripts = Map<String, Script>.from(state.scripts);
          for (var script in scriptsList) {
            scripts[script.sku] = script;
            List<Identifier> texts = scripts[script.sku]!.texts;
            _wordTextBloc.add(WordTextEventAdd(identifiers: texts));
            // dispatch text event here
          }
          emit(state.copyWith(scripts: scripts));
        });
      });
      emit(state.copyWith(fetching: fetching));
    });

    on<ScriptsEventSelected>((event, emit) async {
      Set<Word> selections = Set.from(state.selections);
      if (event.select) {
        selections.add(event.selection);
      } else {
        selections.remove(event.selection);
      }
      emit(state.copyWith(selections: selections));
    });
  }
}
