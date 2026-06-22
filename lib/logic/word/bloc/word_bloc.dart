import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../model/error_response.dart';
import '../../../model/word.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../word_service.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final WordService _wordService = getIt<WordService>();

  WordBloc() : super(WordState.initial()) {
    on<WordEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<RetrieveWordsEvent>((event, emit) async {
      emit(state.copyWith(fetching: true, success: false, failure: false));
      Either<ErrorResponse, List<Word>> results = await _wordService.retrive();

      results.fold(
        (error) => emit(
          state.copyWith(fetching: false, success: false, failure: true),
        ),
        (words) => emit(
          state.copyWith(
            fetching: false,
            success: true,
            words: words,
            failure: false,
          ),
        ),
      );
    });

    on<RetrieveWordBySkuEvent>((event, emit) async {
      emit(state.copyWith(fetching: true, success: false, failure: false));
      Either<ErrorResponse, Word> result = await _wordService.retrieveWordBySku(
        event.sku,
      );

      result.fold(
        (error) => emit(
          state.copyWith(fetching: false, success: false, failure: true),
        ),
        (word) => emit(
          state.copyWith(
            fetching: false,
            success: true,
            selection: word,
            failure: false,
          ),
        ),
      );
    });
  }
}
