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

    on<RetrieveScriptsEvent>((event, emit) async {
      emit(state.copyWith(fetching: true));

      await _scriptService.retrive().then((result) {
        result.fold(
          (error) => emit(state.copyWith(fetching: false, error: error)),
          (success) {
            // _scriptSubject.add(scripts);
            //Stream<List<Script>> resultStream = Stream.value(scripts);
            emit(
              state.copyWith(fetching: false, success: true, scripts: success),
            );
          },
        );
      });
    });
  }
}
