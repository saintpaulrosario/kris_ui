import 'package:bloc/bloc.dart';
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
  final _payloadService = getIt.get<PayloadService>();
  PayloadBloc() : super(PayloadState.initial()) {
    on<PayloadEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<PayloadEventRetrieveBySku>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      fetching.add(event.sku);

      emit(state.copyWith(fetching: fetching));

      final results = await _payloadService.retrieveBySku(event.sku);

      results.fold(
        (error) {
          fetching.remove(event.sku);
          emit(state.copyWith(fetching: fetching));
        },
        (result) {
          final data = Map<String, Payload>.from(state.data);
          data[event.sku] = result;
          fetching.remove(event.sku);
          emit(state.copyWith(data: data, fetching: fetching));
        },
      );
    });

    on<PayloadEventAdd>((event, emit) {
      List<Identifier> identifiers = event.identifiers;

      for (Identifier identifier in identifiers) {
        add(PayloadEventRetrieveBySku(identifier.sku));
      }
    });
  }
}
