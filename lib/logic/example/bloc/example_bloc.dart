import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kris/logic/example/example.dart';
import 'package:kris/service_locator.dart';

import '../../../model/error_response.dart';
import '../../base_state.dart';
import '../example_service.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final ExampleService _exampleService = getIt<ExampleService>();

  ExampleBloc() : super(ExampleState.initial()) {
    on<ExampleEventFetchBySku>((event, emit) async {
      if (!state.data.containsKey(event.sku) &&
          !state.fetching.contains(event.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.sku)).build(),
          ),
        );

        final result = await _exampleService.retrieveBySku(event.sku);

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

          (example) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.sku] = example).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },
        );
      }
    });
  }
}
