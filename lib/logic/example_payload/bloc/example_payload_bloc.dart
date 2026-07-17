import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/example_payload/example_payload.dart';
import 'package:kris/logic/example_payload/example_payload_service.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/service_locator.dart';
import 'package:meta/meta.dart';

import '../../../model/error_response.dart';

part 'example_payload_event.dart';
part 'example_payload_state.dart';

class ExamplePayloadBloc
    extends Bloc<ExamplePayloadEvent, ExamplePayloadState> {
  ExamplePayloadService _service = getIt<ExamplePayloadService>();

  ExamplePayloadBloc() : super(ExamplePayloadState.initial()) {
    on<ExamplePayloadEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ExamplePayloadEventRetriveByIdentifier>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final result = await _service.retrieveBySku(event.identifier.sku);

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

          (payload) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.identifier.sku] = payload)
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
