import 'package:bloc/bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/service/dialect_service.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';

import 'package:fpdart/fpdart.dart';

import '../../../response/error_response.dart';
import '../../../response/page_result.dart';
import '../../../service_locator.dart';

class DialectBloc
    extends Bloc<BaseEvent, BaseState<Dialect, Text, Content, Payload>> {
  final _service = getIt<DialectService>();

  DialectBloc() : super(BaseState.initial()) {
    on<BaseEvent>((event, emit) async {
      switch (event.type) {
        case WordFetchType.page:
          await _fetchWords(event, emit);
          break;

        case WordFetchType.identifier:
          await _fetchWord(event, emit);
          break;

        case WordFetchType.text:
          await _fetchText(event, emit);
          break;

        case WordFetchType.content:
          await _fetchContent(event, emit);
          break;

        case WordFetchType.payload:
          await _fetchPayload(event, emit);
          break;
        case WordFetchType.select:
          await _select(event, emit);
          break;
        case WordFetchType.texts:
          // TODO: Handle this case.
          throw UnimplementedError();
        case WordFetchType.contents:
          // TODO: Handle this case.
          throw UnimplementedError();
        case WordFetchType.payloads:
          // TODO: Handle this case.
          throw UnimplementedError();
        case WordFetchType.selects:
          // TODO: Handle this case.
          _selects(event, emit);
      }
    });
  }

  Future<void> _fetchWords(BaseEvent event, Emitter emit) async {
    if (state.fetching.contains("all")) {
      return;
    }

    emit(
      state.copyWith(
        fetching: (state.fetching.toBuilder()..add("all")).build(),
      ),
    );

        int number = event.pageNumber ?? state.pageNumber;
    int size = event.pageSize ?? state.pageSize;

    final Either<ErrorResponse, PageResult<Dialect>> results = await _service
        .retrieve(page: number, size: size);

    results.match(
      (ErrorResponse error) {
        emit(
          state.copyWith(
            errors: (state.errors.toBuilder()..["all"] = error).build(),

            fetching: (state.fetching.toBuilder()..remove("all")).build(),
          ),
        );
      },

      (PageResult<Dialect> result) {
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

  Future<void> _fetchWord(BaseEvent event, Emitter emit) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _service.retrieveWord(identifier: event.identifier);

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

  Future<void> _fetchText(BaseEvent event, Emitter emit) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _service.retrieveText(identifier: event.identifier);

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

  Future<void> _fetchContent(BaseEvent event, Emitter emit) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _service.retrieveContent(
        identifier: event.identifier,
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

  Future<void> _fetchPayload(BaseEvent event, Emitter emit) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _service.retrievePayload(
        identifier: event.identifier,
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

  Future<void> _select(event, emit) async {
    final selections = state.selections.toBuilder();

    if (event.selected == false) {
      selections.remove(event.identifier.sku);
    } else {
      selections.add(event.identifier.sku);
    }

    emit(state.copyWith(selections: selections.build()));
  }

  Future<void> _selects(BaseEvent event, Emitter<BaseState> emit) async {
    final selections = state.selections.toBuilder();
    for (final id in event.identifiers) {
      if (event.selected == false) {
        selections.remove(id);
      } else {
        selections.add(id);
      }
    }
    emit(state.copyWith(selections: selections.build()));
  }
}
