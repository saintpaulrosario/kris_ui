import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../../../model/error_response.dart';
import '../../../model/identifier.dart';
import '../../../model/payload.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../payload_service.dart';

part 'payload_event.dart';
part 'payload_state.dart';

class PayloadBloc extends Bloc<PayloadEvent, PayloadState> {
  final PayloadService _payloadService = getIt<PayloadService>();

  PayloadBloc() : super(PayloadState.initial()) {
    on<PayloadEventRetrieveBySku>((event, emit) async {
      if (!state.data.containsKey(event.sku) &&
          !state.fetching.contains(event.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.sku)).build(),
          ),
        );

        final result = await _payloadService.retrieveBySku(event.sku);

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

          (payload) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.sku] = payload).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },
        );
      }
    });

    on<PayloadEventAdd>((event, emit) {
      for (final identifier in event.identifiers) {
        add(PayloadEventRetrieveBySku(identifier.sku));
      }
    });
  }
}
