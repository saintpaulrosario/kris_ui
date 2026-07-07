import 'package:bloc/bloc.dart';
import 'package:kris/logic/language/language.dart';
import 'package:kris/logic/language/language_service.dart';

import '../../../model/error_response.dart';
import '../../../model/identifier.dart';
import '../../../model/word.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../../text/bloc/word_text_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final WordTextBloc _wordTextBloc = getIt<WordTextBloc>();
  final LanguageService _languageService = getIt<LanguageService>();

  LanguageBloc() : super(LanguageState.initial()) {
    on<LanguageEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LanguageEventFetchBySku>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      fetching.add(event.sku);
      emit(state.copyWith(fetching: fetching));
      await _languageService.retrieveBySku(event.sku).then((result) {
        result.fold((error) {}, (script) {
          Map<String, Language> languages = Map<String, Language>.from(
            state.languages,
          );
          languages[event.sku] = script;
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
        result.fold((error) {}, (scriptsList) {
          Map<String, Language> languages = Map<String, Language>.from(
            state.languages,
          );
          for (var script in scriptsList) {
            languages[script.sku] = script;
            List<Identifier> texts = languages[script.sku]!.texts;
            _wordTextBloc.add(WordTextEventAdd(identifiers: texts));
            // dispatch text event here
          }
          emit(state.copyWith(scripts: languages));
        });
      });
      emit(state.copyWith(fetching: fetching));
    });
  }
}
