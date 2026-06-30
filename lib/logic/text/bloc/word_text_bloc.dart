import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../model/error_response.dart';
import '../../../model/word_text.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../word_text_service.dart';

part 'word_text_event.dart';
part 'word_text_state.dart';

class WordTextBloc extends Bloc<WordTextEvent, WordTextState> {
  final WordTextService _wordTextService = getIt<WordTextService>();

  WordTextBloc() : super(WordTextState.initial()) {
    on<WordTextEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<WordTextEventRetrieveBySku>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      fetching.add(event.sku);

      emit(state.copyWith(fetching: fetching));

      final results = await _wordTextService.retrieveBySku(event.sku);

      results.fold(
        (error) {
          emit(state.copyWith(errors: {...state.errors, event.sku: error}));
        },
        (result) {
          final texts = Map<String, WordText>.from(state.texts);
          texts[event.sku] = result;
          emit(state.copyWith(texts: texts));
        },
      );
      fetching.remove(event.sku);
      emit(state.copyWith(fetching: fetching));
    });
  }
}
