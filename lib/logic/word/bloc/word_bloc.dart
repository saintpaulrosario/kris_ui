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
      emit(state.copyWith(fetching: true));
      Either<ErrorResponse, List<Word>> results = await _wordService.retrive();

      results.fold(
        (error) => emit(state.copyWith(fetching: false, success: false)),
        (success) => emit(
          state.copyWith(fetching: false, success: true, words: success),
        ),
      );
    });
  }
}
