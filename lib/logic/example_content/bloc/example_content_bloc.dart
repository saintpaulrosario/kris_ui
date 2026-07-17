import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/service_locator.dart';
import 'package:meta/meta.dart';

import '../../../model/content.dart';
import '../../../model/error_response.dart';
import '../../base_state.dart';
import '../example_content.dart';
import '../example_content_service.dart';

part 'example_content_event.dart';
part 'example_content_state.dart';

class ExampleContentBloc
    extends Bloc<ExampleContentEvent, ExampleContentState> {
  ExampleContentService _service = getIt<ExampleContentService>();

  ExampleContentBloc() : super(ExampleContentState.initial()) {
    on<ExampleContentEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ExampleContentEventFetchByIdentifier>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final Either<ErrorResponse, ExampleContent> result = await _service
            .fetchByIdentifier(event.identifier);

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

          (content) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.identifier.sku] = content)
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
