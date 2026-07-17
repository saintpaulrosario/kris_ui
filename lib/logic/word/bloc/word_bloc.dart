import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/model/identifier.dart';

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
    on<WordEvent>(((event, emit) {
      final selections = state.mayaSelections.toBuilder();

      if (!state.mayaSelections.containsKey('script')) {
        selections['script'] = BuiltMap<String, Word>();
      }

      if (!state.mayaSelections.containsKey('language')) {
        selections['language'] = BuiltMap<String, Word>();
      }

      if (!state.mayaSelections.containsKey('dialect')) {
        selections['dialect'] = BuiltMap<String, Word>();
      }

      final updatedSelections = selections.build();
      emit(state.copyWith(mayaSelections: updatedSelections));
    }));

    on<RetrieveWordsEvent>((event, emit) async {
      if (!state.fetching.contains("all")) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add("all")).build(),
          ),
        );

        final results = await _wordService.retrive(
          page: event.pageNumber,
          size: event.pageSize,
          maya: event.maya,
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
            final scripts = state.scripts;
            final dialects = state.dialects;
            final languages = state.languages;
            for (final word in result.content) {
              data[word.sku] = word;
              if (word.maya.contains("script")) {
                scripts.append(word);
              }
              if (word.maya.contains("language")) {
                languages.append(word);
              }
              if (word.maya.contains("dialect")) {
                dialects.append(word);
              }
            }

            pages[result.number] = result;

            emit(
              state.copyWith(
                data: data.build(),
                scripts: scripts,
                dialects: dialects,
                languages: languages,
                fetching: (state.fetching.toBuilder()..remove("all")).build(),
                pageNumber: result.number,
                pageSize: result.size,
                pages: pages.build(),
              ),
            );
          },
        );
      }
    });

    on<RetrieveWordBySkuEvent>((event, emit) async {
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

    on<WordEventAdd>((event, emit) {
      emit(
        state.copyWith(
          data: (state.data.toBuilder()..[event.word.sku] = event.word).build(),
        ),
      );
    });
  }
}
