import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fpdart/fpdart.dart';

import '../../../model/content.dart';
import '../../../model/error_response.dart';
import '../../../model/identifier.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../content_service.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final ContentService _contentService = getIt<ContentService>();

  ContentBloc() : super(ContentState.initial()) {
    on<ContentEventRetriveByIdentifier>((event, emit) async {
      if (!state.data.containsKey(event.identifier.sku) &&
          !state.fetching.contains(event.identifier.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
                .build(),
          ),
        );

        final Either<ErrorResponse, Content> result = await _contentService
            .retriveBySku(event.identifier.sku);

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
