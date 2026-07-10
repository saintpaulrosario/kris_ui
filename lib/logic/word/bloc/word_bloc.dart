import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/response/page_result.dart';

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
    on<RetrieveWordsEvent>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      fetching.add("all");

      emit(state.copyWith(fetching: fetching));

      final results = await _wordService.retrive(
        page: event.page,
        size: event.size,
      );

      results.fold(
        (error) {
          fetching.remove("all");

          emit(
            state.copyWith(
              fetching: fetching,
              errors: {...state.errors, "all": error},
            ),
          );
        },
        (result) {
          final data = Map<String, Word>.from(state.data);
          final content = result.content;
          for (final word in content) {
            data[word.sku] = word;
          }

          fetching.remove("all");

          emit(state.copyWith(data: data, fetching: fetching, page: result));
        },
      );
    });

    on<RetrieveWordBySkuEvent>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);

      fetching.add(event.sku);

      emit(state.copyWith(fetching: fetching));

      final results = await _wordService.retrieveWordBySku(event.sku);

      results.fold(
        (error) {
          fetching.remove(event.sku);

          emit(
            state.copyWith(
              fetching: fetching,
              errors: {...state.errors, event.sku: error},
            ),
          );
        },
        (word) {
          final data = Map<String, Word>.from(state.data);

          data[word.sku] = word;

          fetching.remove(event.sku);

          emit(state.copyWith(data: data, fetching: fetching));
        },
      );
    });

    on<WordEventAdd>((event, emit) {
      final data = Map<String, Word>.from(state.data);

      data[event.word.sku] = event.word;

      emit(state.copyWith(data: data));
    });
  }
}
