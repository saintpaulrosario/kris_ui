import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/base_state.dart';

import '../../../model/error_response.dart';
import '../../../model/word.dart';
import '../../../service_locator.dart';
import '../../../response/page_result.dart';
import '../word_service.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final WordService _wordService = getIt<WordService>();

  WordBloc() : super(WordState.initial()) {
    on<RetrieveWordsEvent>((event, emit) async {
      if (!state.fetching.contains("all")) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add("all")).build(),
          ),
        );

        final results = await _wordService.retrive(
          page: event.page,
          size: event.size,
        );

        results.fold(
          (ErrorResponse error) {
            emit(
              state.copyWith(
                fetching: (state.fetching.toBuilder()..remove("all")).build(),

                errors: (state.errors.toBuilder()..["all"] = error).build(),
              ),
            );
          },

          (PageResult<Word> result) {
            final data = state.data.toBuilder();

            for (final word in result.content) {
              data[word.sku] = word;
            }

            emit(
              state.copyWith(
                data: data.build(),

                fetching: (state.fetching.toBuilder()..remove("all")).build(),

                page: result,
              ),
            );
          },
        );
      }
    });

    on<RetrieveWordBySkuEvent>((event, emit) async {
      if (!state.data.containsKey(event.sku) &&
          !state.fetching.contains(event.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.sku)).build(),
          ),
        );

        final results = await _wordService.retrieveWordBySku(event.sku);

        results.fold(
          (error) {
            emit(
              state.copyWith(
                errors: (state.errors.toBuilder()..[event.sku] = error).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },

          (word) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[word.sku] = word).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },
        );
      }
    });

    on<WordEventAdd>((event, emit) {
      emit(
        state.copyWith(
          data: (state.data.toBuilder()..[event.word.sku] = event.word).build(),
        ),
      );
    });
  }
}
