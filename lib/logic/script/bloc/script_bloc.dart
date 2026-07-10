import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
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

class ScriptBloc extends Bloc<ScriptEvent, ScriptState> {
  final ContentBloc _contentBloc = getIt<ContentBloc>();
  final ScriptService _scriptService = getIt<ScriptService>();

  final BehaviorSubject<Script> _scriptSubject;

  ScriptBloc()
    : _scriptSubject = BehaviorSubject<Script>(),
      super(ScriptState.initial()) {
    on<ScriptEventRetrieveBySku>((event, emit) async {
      if (!state.data.containsKey(event.sku) &&
          !state.fetching.contains(event.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.sku)).build(),
          ),
        );

        final result = await _scriptService.retriveBySku(event.sku);

        result.fold(
          (error) {
            emit(
              state.copyWith(
                errors: (state.errors.toBuilder()..[event.sku] = error).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },

          (script) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.sku] = script).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },
        );
      }
    });

    on<RetrieveScriptsEvent>((event, emit) async {
      if (state.data.isEmpty) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add("all")).build(),
          ),
        );

        final result = await _scriptService.retriveAll();

        result.fold(
          (error) {
            emit(
              state.copyWith(
                errors: (state.errors.toBuilder()..["all"] = error).build(),

                fetching: (state.fetching.toBuilder()..remove("all")).build(),
              ),
            );
          },

          (scriptsList) {
            final scripts = state.data.toBuilder();

            for (final script in scriptsList) {
              scripts[script.sku] = script;

              _contentBloc.add(ContentEventAdd(script.contents));
            }

            emit(
              state.copyWith(
                data: scripts.build(),

                fetching: (state.fetching.toBuilder()..remove("all")).build(),
              ),
            );
          },
        );
      }
    });

    on<ScriptsEventSelected>((event, emit) {
      final selections = state.selections.toBuilder();

      if (event.select) {
        selections.add(event.selection);
      } else {
        selections.remove(event.selection);
      }

      emit(state.copyWith(selections: selections.build()));
    });
  }

  @override
  Future<void> close() {
    _scriptSubject.close();
    return super.close();
  }
}
