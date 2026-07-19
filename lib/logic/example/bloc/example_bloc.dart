import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/example/example.dart';
import 'package:kris/model/identifier.dart';
import 'package:meta/meta.dart';

import '../../../model/error_response.dart';
import '../../../service_locator.dart';
import '../example_service.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleService _service = getIt<ExampleService>();

  ExampleBloc() : super(ExampleState.initial()) {
    on<ExampleEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ExampleEventFetch>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final results = await _service.retrieveByIdentifier(event.identifier);

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

    on<ExampleEventFetchByWord>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final results = await _service.retrieveByWordIdentifier(
          event.identifier,
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
  }
}
