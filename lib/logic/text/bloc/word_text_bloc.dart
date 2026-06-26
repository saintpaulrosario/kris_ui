import 'package:bloc/bloc.dart';
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
      emit(state.copyWith(fetching: true, success: false));
      final results = await _wordTextService.retrieveAll(sku: event.sku);

      results.fold(
        (error) =>
            emit(state.copyWith(fetching: false, success: false, error: error)),
        (text) => emit(
          state.copyWith(fetching: false, success: true, selection: text),
        ),
      );
    });

    on<WordTextEventRetrieveByTextAndWordSku>((event, emit) async {
      emit(state.copyWith(fetching: true, success: false));
      final results = await _wordTextService.retriveByTextAndWordSkus(
        textIdentifier: event.textSku,
        wordIdentifier: event.wordSku,
      );

      results.fold(
        (error) =>
            emit(state.copyWith(fetching: false, success: false, error: error)),
        (text) => emit(
          state.copyWith(fetching: false, success: true, selection: text),
        ),
      );
    });

    on<WordTextEventRetrieveByWordSku>((event, emit) async {
      emit(state.copyWith(fetching: true, success: false));
      final results = await _wordTextService.retriveByWordSku(
        wordIdentifier: event.wordSku,
      );

      results.fold(
        (error) =>
            emit(state.copyWith(fetching: false, success: false, error: error)),
        (texts) =>
            emit(state.copyWith(fetching: false, success: true, texts: texts)),
      );
    });
  }
}
