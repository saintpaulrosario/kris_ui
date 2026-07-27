import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kris/logic/example_text/example_text.dart';
import 'package:kris/logic/example_text/example_text_service.dart';
import 'package:kris/logic/text/bloc/word_text_bloc.dart';
import 'package:kris/logic/identifier.dart';
import 'package:kris/service_locator.dart';
import 'package:meta/meta.dart';

import '../../error_response.dart';
import '../../base_state.dart';

part 'example_text_event.dart';
part 'example_text_state.dart';

class ExampleTextBloc extends Bloc<ExampleTextEvent, ExampleTextState> {
  final _service = getIt<ExampleTextService>();

  ExampleTextBloc() : super(ExampleTextState.initial()) {
    on<ExampleTextEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ExampleTextEventFetchByIdentifier>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final result = await _service.retrieveByIdentifier(event.identifier);

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
  }
}
