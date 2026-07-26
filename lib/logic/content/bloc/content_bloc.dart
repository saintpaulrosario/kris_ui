import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fpdart/fpdart.dart';

import '../../../model/identifier.dart';
import '../../../response/page_result.dart';
import '../content.dart';
import '../../../model/error_response.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../content_service.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final ContentService _contentService = getIt<ContentService>();

  ContentBloc() : super(ContentState.initial()) {
    on<ContentEventFetchAll>((event, emit) async {
      if (!state.fetching.contains("all")) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add("all")).build(),
          ),
        );

        final results = await _contentService.retrive(
          page: event.pageNumber,
          size: event.pageSize,
        );

        results.fold(
          (ErrorResponse error) {
            emit(
              state.copyWith(
                fetching: (state.fetching.toBuilder()..remove("all")).build(),
                errors: (state.errors.toBuilder()..["all"] = error).build(),
              ),
            );
          },
          (PageResult<Content> result) {
            final data = state.data.toBuilder();
            final pages = state.pages.toBuilder();

            for (final content in result.content) {
              data[content.sku] = content;
            }

            pages[result.number] = result;

            emit(
              state.copyWith(
                data: data.build(),
                fetching: (state.fetching.toBuilder()..remove("all")).build(),
                pageNumber: result.number,
                pageSize: result.size,
                pages: pages.build(),
              ),
            );
          },
        );
      }
    });

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
                data: (state.data.toBuilder()..[content.sku] = content).build(),
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
