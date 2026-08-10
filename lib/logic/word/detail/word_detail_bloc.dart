import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kris/logic/word/detail/word_detail_service.dart';
import 'package:kris/model/word_detail.dart';
import 'package:kris/service_locator.dart';
import 'package:meta/meta.dart';

import '../../../response/error_response.dart';
import '../../../response/page_result.dart';

part 'word_detail_event.dart';
part 'word_detail_state.dart';

class WordDetailBloc extends Bloc<WordDetailEvent, WordDetailState> {
  WordDetailService _service = getIt<WordDetailService>();

  WordDetailBloc() : super(WordDetailState.initial()) {
    on<WordDetailEvent>((event, emit) async {
      if (state.fetching.contains("all")) {
        return;
      }

      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add("all")).build(),
        ),
      );

      final results = await _service.retrieve(
        page: event.page,
        size: event.size,
      );

      results.fold(
        (ErrorResponse error) {
          emit(
            state.copyWith(
              errors: (state.errors.toBuilder()..["all"] = error).build(),

              fetching: (state.fetching.toBuilder()..remove("all")).build(),
            ),
          );
        },

        (PageResult<WordDetail> result) {
          final data = state.data.toBuilder();

          for (final WordDetail detail in result.content) {
            data[detail.word.sku] = detail;
          }
          emit(
            state.copyWith(
              pages: (state.pages.toBuilder()..[result.page.number] = result)
                  .build(),
              data: data.build(),

              pageNumber: result.page.number,
              pageSize: result.page.size,

              fetching: (state.fetching.toBuilder()..remove("all")).build(),
            ),
          );
        },
      );
    });
  }
}
