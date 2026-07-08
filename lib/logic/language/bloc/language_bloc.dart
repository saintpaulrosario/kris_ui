import 'package:bloc/bloc.dart';
import 'package:kris/logic/language/language.dart';
import 'package:kris/logic/language/language_service.dart';
import 'package:kris/logic/word/bloc/word_bloc.dart';

import '../../../model/error_response.dart';
import '../../../model/identifier.dart';
import '../../../model/word.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../../text/bloc/word_text_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final WordBloc _wordBloc = getIt<WordBloc>();
  final LanguageService _languageService = getIt<LanguageService>();

  LanguageBloc() : super(LanguageState.initial()) {
    on<LanguageEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LanguageEventSelected>((event, emit) {
      Set<Word> selections = Set.from(state.selections);
      if (event.select) {
        selections.add(event.selection);
      } else {
        selections.remove(event.selection);
      }

      emit(state.copyWith(selections: selections));
    });

    on<LanguageEventFetchBySku>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      fetching.add(event.sku);
      emit(state.copyWith(fetching: fetching));
      await _languageService.retrieveBySku(event.sku).then((result) {
        result.fold((error) {}, (language) {
          Map<String, Language> languages = Map<String, Language>.from(
            state.languages,
          );
          languages[event.sku] = language;
          _wordBloc.add(WordEventAdd(word: language));
          emit(state.copyWith(scripts: languages));
        });
      });
      fetching.remove(event.sku);
      emit(state.copyWith(fetching: fetching));
    });

    on<LanguageEventFetchAll>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      emit(state.copyWith(fetching: fetching));
      await _languageService.retrieveAll().then((result) {
        result.fold((error) {}, (result) {
          Map<String, Language> languages = Map<String, Language>.from(
            state.languages,
          );
          for (var language in result) {
            languages[language.sku] = language;

            _wordBloc.add(WordEventAdd(word: language));

            // dispatch text event here
          }
          emit(state.copyWith(scripts: languages));
        });
      });
      emit(state.copyWith(fetching: fetching));
    });
  }
}
