import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/service/definition_service.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/definition.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';

import 'package:fpdart/fpdart.dart';

import '../../../response/error_response.dart';
import '../../../response/page_result.dart';
import '../../../service_locator.dart';
import '../../model/definition_trait.dart';

class DefinitionBloc
    extends
        Bloc<
          BaseEvent,
          BaseState<Definition, Text, Content, Payload, DefinitionTrait>
        > {
  final _service = getIt<DefinitionService>();

  DefinitionBloc() : super(BaseState.initial()) {
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
          // TODO: Handle this case.
          throw UnimplementedError();
        case WordFetchType.texts:
          await _fetchTexts(event, emit);
          break;
        case WordFetchType.contents:
          await _fetchContents(event, emit);
          break;
        case WordFetchType.payloads:
          await _fetchPayloads(event, emit);
        case WordFetchType.selects:
          // TODO: Handle this case.
          throw UnimplementedError();
        case WordFetchType.trait:
          await _fetchTrait(event, emit);

        case WordFetchType.traits:
          await _fetchTraits(event, emit);
        case WordFetchType.wordTrait:
          await _fetchWordTrait(event, emit);
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
    List<String> scripts = event.scripts!.map((x) => x.sku).toList();
    List<String> skus = event.identifiers.map((x) => x.sku).toList();
    final Either<ErrorResponse, PageResult<Definition>> results = await _service
        .retrieve(
          page: number,
          size: size,
          scripts: scripts,
          identifiers: skus,
        );

    results.match(
      (ErrorResponse error) {
        emit(
          state.copyWith(
            errors: (state.errors.toBuilder()..["all"] = error).build(),

            fetching: (state.fetching.toBuilder()..remove("all")).build(),
          ),
        );
      },

      (PageResult<Definition> result) {
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

  Future<void> _fetchTexts(BaseEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        data: state.data,
        fetching:
            (state.fetching.toBuilder()
                  ..addAll(event.identifiers.map((x) => x.sku)))
                .build(),
      ),
    );

    final results = await _service.retrieveTexts(
      identifiers: event.identifiers,
      scripts: event.scripts!.map((x) => x.sku).toList(),
    );

    results.fold(
      (error) {
        emit(
          state.copyWith(
            errors: (state.errors.toBuilder()..[event.identifier.sku] = error)
                .build(),
            fetching:
                (state.fetching.toBuilder()
                      ..removeAll(event.identifiers.map((x) => x.sku)))
                    .build(),
          ),
        );
      },
      (List<Text> texts) {
        final data = state.texts.toBuilder();
        // data.clear();
        for (final text in texts) {
          data[text.sku] = text;
        }

        emit(
          state.copyWith(
            texts: data.build(),
            fetching:
                (state.fetching.toBuilder()
                      ..removeAll(event.identifiers.map((x) => x.sku)))
                    .build(),
          ),
        );
      },
    );
  }

  Future<void> _fetchContents(BaseEvent event, Emitter emit) async {
    final skus = event.identifiers.map((x) => x.sku).toList();

    emit(
      state.copyWith(
        fetching: (state.fetching.toBuilder()..addAll(skus)).build(),
      ),
    );

    final results = await _service.retrieveContents(
      identifiers: event.identifiers,
      scripts: event.scripts!.map((x) => x.sku).toList(),
      languages: event.languages!.map((x) => x.sku).toList(),
    );

    results.fold(
      (error) {
        emit(
          state.copyWith(
            errors:
                (state.errors.toBuilder()
                      ..addAll({for (final sku in skus) sku: error}))
                    .build(),
            fetching: (state.fetching.toBuilder()..removeAll(skus)).build(),
          ),
        );
      },
      (List<Content> contents) {
        final data = state.contents.toBuilder();

        for (final content in contents) {
          data[content.sku] = content;
        }

        emit(
          state.copyWith(
            contents: data.build(),
            fetching: (state.fetching.toBuilder()..removeAll(skus)).build(),
          ),
        );
      },
    );
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

  Future<void> _fetchPayloads(BaseEvent event, Emitter emit) async {
    final skus = event.identifiers.map((x) => x.sku).toList();

    emit(
      state.copyWith(
        fetching: (state.fetching.toBuilder()..addAll(skus)).build(),
      ),
    );

    final results = await _service.retrievePayloads(
      identifiers: event.identifiers,
      scripts: event.scripts!.map((x) => x.sku).toList(),
      languages: event.languages!.map((x) => x.sku).toList(),
      dialects: event.dialects!.map((x) => x.sku).toList(),
    );

    results.fold(
      (error) {
        emit(
          state.copyWith(
            errors:
                (state.errors.toBuilder()
                      ..addAll({for (final sku in skus) sku: error}))
                    .build(),
            fetching: (state.fetching.toBuilder()..removeAll(skus)).build(),
          ),
        );
      },
      (List<Payload> payloads) {
        final data = state.payloads.toBuilder();

        for (final payload in payloads) {
          data[payload.sku] = payload;
        }

        emit(
          state.copyWith(
            payloads: data.build(),
            fetching: (state.fetching.toBuilder()..removeAll(skus)).build(),
          ),
        );
      },
    );
  }

  Future<void> _fetchTrait(BaseEvent event, Emitter emit) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _service.retrieveTrait(
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
              traits: (state.traits.toBuilder()..[word.sku] = word).build(),

              fetching:
                  (state.fetching.toBuilder()..remove(event.identifier.sku))
                      .build(),
            ),
          );
        },
      );
    }
  }

  Future<void> _fetchTraits(BaseEvent event, Emitter emit) async {
    final skus = event.identifiers.map((x) => x.sku).toList();

    emit(
      state.copyWith(
        fetching: (state.fetching.toBuilder()..addAll(skus)).build(),
      ),
    );

    final results = await _service.retrieveTraits(
      identifiers: event.identifiers,
      dialects: event.dialects!.map((x) => x.sku).toList(),
    );

    results.fold(
      (error) {
        emit(
          state.copyWith(
            errors:
                (state.errors.toBuilder()
                      ..addAll({for (final sku in skus) sku: error}))
                    .build(),
            fetching: (state.fetching.toBuilder()..removeAll(skus)).build(),
          ),
        );
      },
      (List<DefinitionTrait> payloads) {
        final data = state.traits.toBuilder();

        for (final payload in payloads) {
          data[payload.sku] = payload;
        }

        emit(
          state.copyWith(
            traits: data.build(),
            fetching: (state.fetching.toBuilder()..removeAll(skus)).build(),
          ),
        );
      },
    );
  }

  Future<void> _fetchWordTrait(BaseEvent event, Emitter emit) async {
    if (!state.data.containsKey(event.identifier.sku) &&
        !state.fetching.contains(event.identifier.sku)) {
      emit(
        state.copyWith(
          fetching: (state.fetching.toBuilder()..add(event.identifier.sku))
              .build(),
        ),
      );

      final results = await _service.retrieveWordByTrait(
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

        (Definition definition) {
          emit(
            state.copyWith(
              wordTraits:
                  (state.wordTraits.toBuilder()
                        ..[event.identifier.sku] = definition)
                      .build(),

              fetching: state.fetching.rebuild(
                (builder) => builder.remove(event.identifier.sku),
              ),
            ),
          );
        },
      );
    }
  }
}
