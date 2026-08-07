import 'package:bloc/bloc.dart';

import 'package:kris/logic/base_state.dart';
import 'package:kris/model/translation_content.dart';
import 'package:kris/model/translation_payload.dart';
import 'package:kris/model/translation_text.dart';

import '../../../model/script.dart';
import '../../../response/error_response.dart';
import '../../../service_locator.dart';
import '../../../response/page_result.dart';

import '../../base_event.dart';
import '../../word_service.dart';

class ScriptBloc
    extends
        Bloc<
          BaseEvent,
          BaseState<
            Script,
            TranslationText,
            TranslationContent,
            TranslationPayload
          >
        > {
  final _service =
      getIt<
        WordService<
          Script,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >
      >();

  ScriptBloc() : super(BaseState.initial()) {
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

  Future<void> _fetchWords(BaseEvent event, emit) async {
    if (state.fetching.contains("all")) {
      return;
    }

    emit(
      state.copyWith(
        fetching: (state.fetching.toBuilder()..add("all")).build(),
      ),
    );

    final results = await _service.retrieve(
      endpoint: "script",
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

  Future<void> _fetchWordBySku(BaseEvent event, emit) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _service.retrieveWordBySku(
        endpoint: "script",
        sku: event.identifier.sku,
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

  Future<void> _fetchTextBySku(BaseEvent event, emit) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _service.retrieveTextBySku(
        endpoint: "script",
        sku: event.identifier.sku,
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

  Future<void> _fetchContentBySku(BaseEvent event, emit) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _service.retrieveContentBySku(
        endpoint: "script",
        sku: event.identifier.sku,
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

  Future<void> _fetchPayloadBySku(BaseEvent event, emit) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _service.retrievePayloadBySku(
        endpoint: "script",
        sku: event.identifier.sku,
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

  Future<void> _select(BaseEvent event, emit) async {
    final selections = state.selections.toBuilder();

    if (event.selected ?? false) {
      selections.add(event.identifier.sku);
    } else {
      selections.remove(event.identifier.sku);
    }

    emit(state.copyWith(selections: selections.build()));
  }
}
