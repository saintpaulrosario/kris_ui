import 'package:bloc/bloc.dart';
import 'package:kris/logic/dialect/dialect.dart';
import 'package:kris/logic/dialect/dialect_service.dart';
import 'package:meta/meta.dart';

import '../../../model/error_response.dart';
import '../../../model/identifier.dart';
import '../../../model/word.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../../text/bloc/word_text_bloc.dart';

part 'dialect_event.dart';
part 'dialect_state.dart';

class DialectBloc extends Bloc<DialectEvent, DialectState> {
  final WordTextBloc _wordTextBloc = getIt<WordTextBloc>();
  final DialectService _dialectService = getIt<DialectService>();

  DialectBloc() : super(DialectState.initial()) {
    on<DialectEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<DialectEventFetchBySku>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      fetching.add(event.sku);
      emit(state.copyWith(fetching: fetching));
      await _dialectService.retrieveBySku(event.sku).then((result) {
        result.fold((error) {}, (script) {
          Map<String, Dialect> dialects = Map<String, Dialect>.from(
            state.dialects,
          );
          dialects[event.sku] = script;
          emit(state.copyWith(dialects: dialects));
        });
      });
      fetching.remove(event.sku);
      emit(state.copyWith(fetching: fetching));
    });

    on<DialectEventFetchAll>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      emit(state.copyWith(fetching: fetching));
      await _dialectService.retrieveAll().then((result) {
        result.fold((error) {}, (scriptsList) {
          Map<String, Dialect> dialects = Map<String, Dialect>.from(
            state.dialects,
          );
          for (var script in scriptsList) {
            dialects[script.sku] = script;
            List<Identifier> texts = dialects[script.sku]!.texts;
            _wordTextBloc.add(WordTextEventAdd(identifiers: texts));
            // dispatch text event here
          }
          emit(state.copyWith(dialects: dialects));
        });
      });
      emit(state.copyWith(fetching: fetching));
    });
  }
}
