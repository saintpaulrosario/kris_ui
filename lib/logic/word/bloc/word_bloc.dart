import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/content/bloc/content_bloc.dart';

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
        final Map<String, Word> data = Map.from(state.data);
        for (var word in results) {
          data[word.sku] = word;
          emit(state.copyWith(data: data));
        }
      });
    });

    on<RetrieveWordBySkuEvent>((event, emit) async {
      if (!state.data.containsKey(event.sku)) {
        Either<ErrorResponse, Word> results = await _wordService
            .retrieveWordBySku(event.sku);

        Set<String> fetching = Set.from(state.fetching);
        fetching.add(event.sku);

        results.fold(
          (error) {
            fetching.remove(event.sku);
            emit(state.copyWith(fetching: fetching));
          },
          (result) {
            Map<String, Word> data = Map.from(state.data);
            data[result.sku] = result;

            fetching.remove(event.sku);
            emit(state.copyWith(data: data, fetching: fetching));
          },
        );
      }
    });

    on<WordEventAdd>((event, emit) {
      final words = Map<String, Word>.from(state.data);
      words[event.word.sku] = event.word;
      emit(state.copyWith(data: words));
      //_contentBloc.add(ContentEventAdd(event.word.contents));
      //add(RetrieveWordBySkuEvent(sku: event.word.sku));
    });
  }
}
