import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../model/error_response.dart';
import '../../../model/identifier.dart';
import '../../../model/word_text.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../../content/bloc/content_bloc.dart';
import '../word_text_service.dart';

part 'word_text_event.dart';
part 'word_text_state.dart';

class WordTextBloc extends Bloc<WordTextEvent, WordTextState> {
  final ContentBloc _contentBloc = getIt<ContentBloc>();
  final WordTextService _wordTextService = getIt<WordTextService>();

  WordTextBloc() : super(WordTextState.initial()) {
    on<WordTextEventRetrieveBySku>((event, emit) async {
      if (!state.data.containsKey(event.sku) &&
          !state.fetching.contains(event.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.sku)).build(),
          ),
        );

        final result = await _wordTextService.retrieveBySku(event.sku);

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

          (wordText) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.sku] = wordText).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },
        );
      }
    });

    on<WordTextEventAdd>((event, emit) {
      //add(RetrieveWordBySkuEvent(sku: event.identifier.sku));
    });
  }
}
