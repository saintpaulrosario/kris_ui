import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/medium/medium_state.dart';
import 'package:kris/logic/medium/service/medium_service.dart';
import 'package:kris/model/identifier.dart';

import '../../../model/medium.dart';
import '../../../response/error_response.dart';
import '../../../service_locator.dart';

part 'medium_event.dart';

class MediumBloc extends Bloc<MediumEvent, MediumState<Medium>> {
  final MediumService _service = getIt<MediumService>();

  MediumBloc() : super(MediumState.initial()) {
    on<MediumEventFetch>((event, emit) async {
      if (!state.data.containsKey(event.sku) &&
          !state.fetching.contains(event.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.sku)).build(),
          ),
        );

        final Either<ErrorResponse, Medium> result = await _service
            .retriveBySku(event.sku);

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

          (image) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.sku] = image).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },
        );
      }
    });

    on<MediumEventFetchIdentifiers>((event, emit) async {
      final skus = event.identifiers.map((x) => x.sku).toList();

      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..addAll(skus)).build(),
        ),
      );

      final results = await _service.fetch(identifiers: skus);

      results.fold(
        (error) {
          emit(
            state.copyWith(
              errors:
                  (state.errors.toBuilder()
                        ..addAll({for (final sku in skus) sku: error}))
                      .build(),
              fetching: (state.fetching.toBuilder()..removeAll(skus)).build(),
            ),
          );
        },
        (List<Medium> mediums) {
          final data = state.data.toBuilder();

          for (final item in mediums) {
            data[item.sku] = item;
          }

          emit(
            state.copyWith(
              data: data.build(),
              fetching: (state.fetching.toBuilder()..removeAll(skus)).build(),
            ),
          );
        },
      );
    });
  }
}
