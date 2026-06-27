import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../model/content.dart';
import '../../../model/error_response.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../content_service.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final _contentService = getIt.get<ContentService>();
  ContentBloc() : super(ContentState.initial()) {
    on<ContentEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ContentEventRetriveByTextSku>((event, emit) async {
      emit(state.copyWith(fetching: true, success: false, failure: false));
      final results = await _contentService.retriveByTextIdentifier(
        event.textSku,
      );

      results.fold(
        (error) => emit(
          state.copyWith(
            fetching: false,
            success: false,
            failure: true,
            error: error,
          ),
        ),
        (contents) => emit(
          state.copyWith(
            fetching: false,
            success: true,
            failure: false,
            contents: contents,
          ),
        ),
      );
    });

    on<ContentEventRetriveBySku>((event, emit) async {
      emit(state.copyWith(fetching: true, success: false, failure: false));
      final Either<ErrorResponse, Content> result = await _contentService
          .retriveBySku(event.sku);

      result.fold(
        (error) => emit(
          state.copyWith(
            fetching: false,
            success: false,
            failure: true,
            error: error,
          ),
        ),
        (content) => emit(
          state.copyWith(
            fetching: false,
            success: true,
            failure: false,
            selection: content,
          ),
        ),
      );
    });
  }
}
