import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/model/word_content.dart';
import 'package:kris/model/word_payload.dart';
import 'package:kris/model/word_text.dart';

import '../../../response/error_response.dart';
import '../../../model/identifier.dart';
import '../../../model/word.dart';
import '../../../service_locator.dart';
import '../../../response/page_result.dart';
import '../word_service.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final WordService _wordService = getIt<WordService>();

  WordBloc() : super(WordState.initial()) {
    on<WordEvent>(((event, emit) {
      // final selections = state.mayaSelections.toBuilder();

      // if (!state.mayaSelections.containsKey('script')) {
      //   selections['script'] = BuiltMap<String, Word>();
      // }

      // if (!state.mayaSelections.containsKey('language')) {
      //   selections['language'] = BuiltMap<String, Word>();
      // }

      // if (!state.mayaSelections.containsKey('dialect')) {
      //   selections['dialect'] = BuiltMap<String, Word>();
      // }

      // final updatedSelections = selections.build();
      // emit(state.copyWith(mayaSelections: updatedSelections));
    }));

    on<WordEventFetch>((event, emit) async {
      if (!state.fetching.contains("all")) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add("all")).build(),
          ),
        );

        final results = await _wordService.retrive(
          page: event.pageNumber,
          size: event.pageSize,
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
            final pages = state.pages.toBuilder();

            pages[result.page.number] = result;

            emit(
              state.copyWith(
                data: data.build(),
                fetching: (state.fetching.toBuilder()..remove("all")).build(),
                pageNumber: result.page.number,
                pageSize: result.page.size,
                pages: pages.build(),
              ),
            );
          },
        );
      }
    });

    on<RetrieveWordsEventFetchBySku>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final results = await _wordService.retrieveWordBySku(
          event.identifier.sku,
        );

        results.fold(
          (error) {
            emit(
              state.copyWith(
                errors:
                    (state.errors.toBuilder()..[event.identifier.sku] = error)
                        .build(),

                fetching:
                    (state.fetching.toBuilder()..remove(event.identifier.sku))
                        .build(),
              ),
            );
          },

          (word) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[word.sku] = word).build(),

                fetching:
                    (state.fetching.toBuilder()..remove(event.identifier.sku))
                        .build(),
              ),
            );
          },
        );
      }
    });

    on<RetrieveWordsEventFetchTextBySku>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final results = await _wordService.retrieveTextBySku(
          event.identifier.sku,
        );

        results.fold(
          (error) {
            emit(
              state.copyWith(
                errors:
                    (state.errors.toBuilder()..[event.identifier.sku] = error)
                        .build(),

                fetching:
                    (state.fetching.toBuilder()..remove(event.identifier.sku))
                        .build(),
              ),
            );
          },

          (word) {
            emit(
              state.copyWith(
                texts: (state.texts.toBuilder()..[word.sku] = word).build(),

                fetching:
                    (state.fetching.toBuilder()..remove(event.identifier.sku))
                        .build(),
              ),
            );
          },
        );
      }
    });

    on<RetrieveWordsEventFetchContentBySku>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final results = await _wordService.retrieveContentBySku(
          event.identifier.sku,
        );

        results.fold(
          (error) {
            emit(
              state.copyWith(
                errors:
                    (state.errors.toBuilder()..[event.identifier.sku] = error)
                        .build(),

                fetching:
                    (state.fetching.toBuilder()..remove(event.identifier.sku))
                        .build(),
              ),
            );
          },

          (word) {
            emit(
              state.copyWith(
                contents: (state.contents.toBuilder()..[word.sku] = word)
                    .build(),

                fetching:
                    (state.fetching.toBuilder()..remove(event.identifier.sku))
                        .build(),
              ),
            );
          },
        );
      }
    });

    on<RetrieveWordsEventFetchPayloadBySku>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final results = await _wordService.retrievePayloadBySku(
          event.identifier.sku,
        );

        results.fold(
          (error) {
            emit(
              state.copyWith(
                errors:
                    (state.errors.toBuilder()..[event.identifier.sku] = error)
                        .build(),

                fetching:
                    (state.fetching.toBuilder()..remove(event.identifier.sku))
                        .build(),
              ),
            );
          },

          (word) {
            emit(
              state.copyWith(
                payloads: (state.payloads.toBuilder()..[word.sku] = word)
                    .build(),

                fetching:
                    (state.fetching.toBuilder()..remove(event.identifier.sku))
                        .build(),
              ),
            );
          },
        );
      }
    });
  }
}
