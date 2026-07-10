import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kris/logic/language/language.dart';
import 'package:kris/logic/language/language_service.dart';
import 'package:kris/logic/word/bloc/word_bloc.dart';

import '../../../model/error_response.dart';
import '../../../model/word.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final WordBloc _wordBloc = getIt<WordBloc>();
  final LanguageService _languageService = getIt<LanguageService>();

  LanguageBloc() : super(LanguageState.initial()) {
    on<LanguageEventSelected>((event, emit) {
      final selections = state.selections.toBuilder();

      if (event.select) {
        selections.add(event.selection);
      } else {
        selections.remove(event.selection);
      }

      emit(state.copyWith(selections: selections.build()));
    });

    on<LanguageEventFetchBySku>((event, emit) async {
      if (!state.data.containsKey(event.sku) &&
          !state.fetching.contains(event.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.sku)).build(),
          ),
        );

        final result = await _languageService.retrieveBySku(event.sku);

        result.fold(
          (error) {
            emit(
              state.copyWith(
                errors: (state.errors.toBuilder()..[event.sku] = error).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },

          (language) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.sku] = language).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },
        );
      }
    });

    on<LanguageEventFetchAll>((event, emit) async {
      if (state.data.isEmpty) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add("all")).build(),
          ),
        );

        final result = await _languageService.retrieveAll();

        result.fold(
          (error) {
            emit(
              state.copyWith(
                errors: (state.errors.toBuilder()..["all"] = error).build(),

                fetching: (state.fetching.toBuilder()..remove("all")).build(),
              ),
            );
          },

          (languages) {
            final data = state.data.toBuilder();

            for (final language in languages) {
              data[language.sku] = language;

              _wordBloc.add(WordEventAdd(word: language));
            }

            emit(
              state.copyWith(
                data: data.build(),

                fetching: (state.fetching.toBuilder()..remove("all")).build(),
              ),
            );
          },
        );
      }
    });
  }
}
