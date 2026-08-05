import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';

import 'package:kris/logic/base_state.dart';
import 'package:kris/model/translation_content.dart';
import 'package:kris/model/translation_payload.dart';
import 'package:kris/model/translation_text.dart';

import '../../../model/script.dart';
import '../../../model/script_content.dart';
import '../../../model/script_payload.dart';
import '../../../response/error_response.dart';
import '../../../model/script_text.dart';
import '../../../service_locator.dart';
import '../../../response/page_result.dart';

import '../../base_event.dart';
import '../script_service.dart';

part 'script_state.dart';

class ScriptBloc extends Bloc<BaseEvent, ScriptState> {
  final ScriptService _translationService = getIt<ScriptService>();

  ScriptBloc() : super(ScriptState.initial()) {
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
        case WordFetchType.select:
          await _select(event, emit);
          break;
      }
    });
  }

  Future<void> _fetchWords(BaseEvent event, Emitter<ScriptState> emit) async {
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

      (PageResult<Script> result) {
        final data = state.data.toBuilder();

        for (final word in result.content) {
          data[word.sku] = word;
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
  }

  Future<void> _fetchWordBySku(
    BaseEvent event,
    Emitter<ScriptState> emit,
  ) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _translationService.retrieveWordBySku(
        event.identifier.sku,
      );

      results.fold(
        (error) {
          emit(
            state.copyWith(
              errors: (state.errors.toBuilder()..[event.identifier.sku] = error)
                  .build(),

              fetching:
                  (state.fetching.toBuilder()..remove(event.identifier.sku))
                      .build(),
            ),
          );
        },

        (word) {
          emit(
            state.copyWith(
              data: (state.data.toBuilder()..[word.sku] = word).build(),

              fetching:
                  (state.fetching.toBuilder()..remove(event.identifier.sku))
                      .build(),
            ),
          );
        },
      );
    }
  }

  Future<void> _fetchTextBySku(
    BaseEvent event,
    Emitter<ScriptState> emit,
  ) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _translationService.retrieveTextBySku(
        event.identifier.sku,
      );

      results.fold(
        (error) {
          emit(
            state.copyWith(
              errors: (state.errors.toBuilder()..[event.identifier.sku] = error)
                  .build(),

              fetching:
                  (state.fetching.toBuilder()..remove(event.identifier.sku))
                      .build(),
            ),
          );
        },

        (word) {
          emit(
            state.copyWith(
              texts: (state.texts.toBuilder()..[word.sku] = word).build(),

              fetching:
                  (state.fetching.toBuilder()..remove(event.identifier.sku))
                      .build(),
            ),
          );
        },
      );
    }
  }

  Future<void> _fetchContentBySku(
    BaseEvent event,
    Emitter<ScriptState> emit,
  ) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _translationService.retrieveContentBySku(
        event.identifier.sku,
      );

      results.fold(
        (error) {
          emit(
            state.copyWith(
              errors: (state.errors.toBuilder()..[event.identifier.sku] = error)
                  .build(),

              fetching:
                  (state.fetching.toBuilder()..remove(event.identifier.sku))
                      .build(),
            ),
          );
        },

        (word) {
          emit(
            state.copyWith(
              contents: (state.contents.toBuilder()..[word.sku] = word).build(),

              fetching:
                  (state.fetching.toBuilder()..remove(event.identifier.sku))
                      .build(),
            ),
          );
        },
      );
    }
  }

  Future<void> _fetchPayloadBySku(
    BaseEvent event,
    Emitter<ScriptState> emit,
  ) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _translationService.retrievePayloadBySku(
        event.identifier.sku,
      );

      results.fold(
        (error) {
          emit(
            state.copyWith(
              errors: (state.errors.toBuilder()..[event.identifier.sku] = error)
                  .build(),

              fetching:
                  (state.fetching.toBuilder()..remove(event.identifier.sku))
                      .build(),
            ),
          );
        },

        (word) {
          emit(
            state.copyWith(
              payloads: (state.payloads.toBuilder()..[word.sku] = word).build(),

              fetching:
                  (state.fetching.toBuilder()..remove(event.identifier.sku))
                      .build(),
            ),
          );
        },
      );
    }
  }

  Future<void> _select(BaseEvent event, Emitter<ScriptState> emit) async {
    final selections = state.selections.toBuilder();

    if (event.selected ?? false) {
      selections.add(event.identifier.sku);
    } else {
      selections.remove(event.identifier.sku);
    }

    emit(state.copyWith(selections: selections.build()));
  }
}
