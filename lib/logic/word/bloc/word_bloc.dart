import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/content/bloc/content_bloc.dart';
import 'package:kris/logic/text/bloc/word_text_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word_text.dart';
import 'package:rxdart/subjects.dart';

import '../../../model/error_response.dart';
import '../../../model/word.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../word_service.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final _contentBloc = getIt<ContentBloc>();
  final WordService _wordService = getIt<WordService>();

  WordBloc() : super(WordState.initial()) {
    on<WordEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<RetrieveWordsEvent>((event, emit) async {
      Either<ErrorResponse, List<Word>> results = await _wordService.retrive();

      results.fold((error) {}, (results) {
        final words = state.words;
        for (var word in results) {
          words[word.sku] = word;
          _contentBloc.add(ContentEventAdd(word.contents));
        }
        emit(state.copyWith(words: words));
      });
    });

    on<RetrieveWordBySkuEvent>((event, emit) async {
      Either<ErrorResponse, Word> results = await _wordService
          .retrieveWordBySku(event.sku);

      results.fold((error) {}, (result) {
        final words = state.words;
        words[result.sku] = result;
        emit(state.copyWith(words: words));
        _contentBloc.add(ContentEventAdd(result.contents));
      });
    });

    on<WordEventAdd>((event, emit) {
      final words = Map<String, Word>.from(state.words);
      words[event.word.sku] = event.word;
      emit(state.copyWith(words: words));
      //_contentBloc.add(ContentEventAdd(event.word.contents));
      //add(RetrieveWordBySkuEvent(sku: event.word.sku));
    });

    // on<RetrieveWordBySkuEvent>((event, emit) async {
    //   emit(state.copyWith(fetching: true, success: false, failure: false));
    //   Either<ErrorResponse, Word> result = await _wordService.retrieveWordBySku(
    //     event.sku,
    //   );

    //   result.fold(
    //     (error) => emit(
    //       state.copyWith(fetching: false, success: false, failure: true),
    //     ),
    //     (word) {
    //       //state.selection.add(word);
    //       emit(state.copyWith(fetching: false, success: true, failure: false));
    //     },
    //   );
    // });
  }
}
