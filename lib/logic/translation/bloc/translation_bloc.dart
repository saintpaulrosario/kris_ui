import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';

import 'package:kris/logic/base_state.dart';

import '../../../model/translation_content.dart';
import '../../../model/translation_payload.dart';
import '../../../model/translation_text.dart';
import '../../../response/error_response.dart';
import '../../../model/translation.dart';
import '../../../service_locator.dart';
import '../../../response/page_result.dart';

import '../../base_event.dart';
import '../translation_service.dart';

part 'translation_state.dart';

class TranslationBloc extends Bloc<BaseEvent, TranslationState> {
  final TranslationService _translationService = getIt<TranslationService>();

  TranslationBloc() : super(TranslationState.initial()) {
    on<BaseEvent>((event, emit) async {
      switch (event.type) {
        case WordFetchType.page:
          await _fetchWords(event, emit);
          break;

        case WordFetchType.bySku:
          await _fetchWordBySku(event, emit);
          break;

        case WordFetchType.textBySku:
          await _fetchTextBySku(event, emit);
          break;

        case WordFetchType.contentBySku:
          await _fetchContentBySku(event, emit);
          break;

        case WordFetchType.payloadBySku:
          await _fetchPayloadBySku(event, emit);
          break;
      }
    });
  }

  Future<void> _fetchWords(
    BaseEvent event,
    Emitter<TranslationState> emit,
  ) async {
    if (state.fetching.contains("all")) {
      return;
    }

    emit(
      state.copyWith(
        fetching: (state.fetching.toBuilder()..add("all")).build(),
      ),
    );

    final results = await _translationService.retrieve(
      page: event.pageNumber!,
      size: event.pageSize!,
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

      (PageResult<Translation> result) {
        emit(
          state.copyWith(
            pages: (state.pages.toBuilder()..[result.page.number] = result)
                .build(),

            pageNumber: result.page.number,
            pageSize: result.page.size,

            fetching: (state.fetching.toBuilder()..remove("all")).build(),
          ),
        );
      },
    );
  }

  Future<void> _fetchWordBySku(
    BaseEvent event,
    Emitter<TranslationState> emit,
  ) async {
    final identifier = event.identifier!;

    // keep your existing logic here
  }

  Future<void> _fetchTextBySku(
    BaseEvent event,
    Emitter<TranslationState> emit,
  ) async {
    final identifier = event.identifier!;

    // keep your existing logic here
  }

  Future<void> _fetchContentBySku(
    BaseEvent event,
    Emitter<TranslationState> emit,
  ) async {
    final identifier = event.identifier!;

    // keep your existing logic here
  }

  Future<void> _fetchPayloadBySku(
    BaseEvent event,
    Emitter<TranslationState> emit,
  ) async {
    final identifier = event.identifier!;

    // keep your existing logic here
  }
}
