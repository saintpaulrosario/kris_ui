import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../../error_response.dart';
import '../../identifier.dart';
import '../payload.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../payload_service.dart';

part 'payload_event.dart';
part 'payload_state.dart';

class PayloadBloc extends Bloc<PayloadEvent, PayloadState> {
  final PayloadService _payloadService = getIt<PayloadService>();

  PayloadBloc() : super(PayloadState.initial()) {
    on<PayloadEventRetrieveBySku>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final result = await _payloadService.retrieveBySku(
          event.identifier.sku,
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

    on<PayloadEventAdd>((event, emit) {
      for (final identifier in event.identifiers) {
        add(PayloadEventRetrieveBySku(identifier));
      }
    });
  }
}
