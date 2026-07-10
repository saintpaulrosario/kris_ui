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
    on<ContentEventRetriveBySku>((event, emit) async {
      if (!state.data.containsKey(event.sku) &&
          !state.fetching.contains(event.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.sku)).build(),
          ),
        );

        final Either<ErrorResponse, Content> result = await _contentService
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

          (content) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.sku] = content).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },
        );
      }
    });

    on<ContentEventAdd>((event, emit) {
      for (final identifier in event.identifiers) {
        add(ContentEventRetriveBySku(identifier.sku));
      }
    });
  }
}
