import 'package:bloc/bloc.dart';
import 'package:kris/data/service/script_service.dart';

import 'package:kris/model/script.dart';

import '../../../model/error_response.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import 'package:rxdart/rxdart.dart';

part 'script_event.dart';
part 'script_state.dart';

// TODO should load data from cache if first load

class ScriptBloc extends Bloc<ScriptEvent, ScriptState> {
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
  }
}
