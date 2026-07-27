import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import '../../error_response.dart';
import '../../identifier.dart';
import '../word_text.dart';
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
    on<WordTextEventRetrieveByIdentifier>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final result = await _wordTextService.retrieveByIdentifier(
          event.identifier,
        );

        result.fold(
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

          (wordText) {
            emit(
              state.copyWith(
                data:
                    (state.data.toBuilder()..[event.identifier.sku] = wordText)
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

    on<WordTextEventAdd>((event, emit) {
      //add(RetrieveWordBySkuEvent(sku: event.identifier.sku));
    });
  }
}
