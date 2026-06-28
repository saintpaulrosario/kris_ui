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

    on<WordTextEventRetrieveByWordSku>((event, emit) async {
      final loading = Set<String>.from(state.loading);
      loading.add(event.wordSku);

      emit(state.copyWith(loading: loading));

      final results = await _wordTextService.retrieveByWordSku(event.wordSku);

      final notLoading = Set<String>.from(state.loading);
      notLoading.remove(event.wordSku);
      emit(state.copyWith(loading: notLoading));

      results.fold(
        (error) {
          emit(state.copyWith(errors: {...state.errors, event.wordSku: error}));
        },
        (result) {
          final texts = Map<String, WordText>.from(state.texts);
          for (WordText wordText in result) {
            texts[event.wordSku] = wordText;
          }
          emit(state.copyWith(texts: texts));
        },
      );
    });
  }
}
