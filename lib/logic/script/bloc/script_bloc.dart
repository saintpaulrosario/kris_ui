import 'package:bloc/bloc.dart';
import 'package:kris/data/service/script_service.dart';

import 'package:kris/model/script.dart';
import 'package:kris/model/word.dart';

import '../../../model/error_response.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../content/bloc/content_bloc.dart';

part 'script_event.dart';
part 'script_state.dart';

// TODO should load data from cache if first load

class ScriptBloc extends Bloc<ScriptEvent, ScriptState> {
  final ContentBloc _contentBloc = getIt<ContentBloc>();
  final ScriptService _scriptService = getIt<ScriptService>();

  final BehaviorSubject<Script> _scriptSubject;

  ScriptBloc()
    : _scriptSubject = BehaviorSubject<Script>(),
      super(ScriptState.initial()) {
    on<ScriptEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ScriptEventRetrieveBySku>((event, emit) async {
      if (!state.data.containsKey(event.sku)) {
        final fetching = Set<String>.from(state.fetching);
        fetching.add(event.sku);
        emit(state.copyWith(fetching: fetching));
        await _scriptService.retriveBySku(event.sku).then((result) {
          result.fold(
            (error) {
              fetching.remove(event.sku);
              emit(state.copyWith(fetching: fetching));
            },
            (result) {
              Map<String, Script> data = Map.from(state.data);
              data[event.sku] = result;
              fetching.remove(event.sku);
              emit(state.copyWith(data: data));
            },
          );
        });
      }
    });

    on<RetrieveScriptsEvent>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      emit(state.copyWith(fetching: fetching));
      await _scriptService.retriveAll().then((result) {
        result.fold((error) {}, (scriptsList) {
          Map<String, Script> scripts = Map<String, Script>.from(state.data);
          for (var script in scriptsList) {
            scripts[script.sku] = script;
            _contentBloc.add(ContentEventAdd(script.contents));
            // dispatch text event here
          }
          emit(state.copyWith(data: scripts));
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
