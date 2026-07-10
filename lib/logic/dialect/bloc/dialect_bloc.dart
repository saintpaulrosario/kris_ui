import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kris/logic/dialect/dialect.dart';
import 'package:kris/logic/dialect/dialect_service.dart';
import 'package:kris/logic/word/bloc/word_bloc.dart';

import '../../../model/error_response.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';

part 'dialect_event.dart';
part 'dialect_state.dart';

class DialectBloc extends Bloc<DialectEvent, DialectState> {
  final WordBloc _wordBloc = getIt<WordBloc>();
  final DialectService _dialectService = getIt<DialectService>();

  DialectBloc() : super(DialectState.initial()) {
    on<DialectEventFetchBySku>((event, emit) async {
      if (!state.data.containsKey(event.sku) &&
          !state.fetching.contains(event.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.sku)).build(),
          ),
        );

        final result = await _dialectService.retrieveBySku(event.sku);

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

          (dialect) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.sku] = dialect).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },
        );
      }
    });

    on<DialectEventFetchAll>((event, emit) async {
      if (state.data.isEmpty) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add("all")).build(),
          ),
        );

        final result = await _dialectService.retrieveAll();

        result.fold(
          (error) {
            emit(
              state.copyWith(
                errors: (state.errors.toBuilder()..["all"] = error).build(),

                fetching: (state.fetching.toBuilder()..remove("all")).build(),
              ),
            );
          },

          (dialects) {
            final data = state.data.toBuilder();

            for (final dialect in dialects) {
              data[dialect.sku] = dialect;

              _wordBloc.add(WordEventAdd(word: dialect));
            }

            emit(
              state.copyWith(
                data: data.build(),

                fetching: (state.fetching.toBuilder()..remove("all")).build(),
              ),
            );
          },
        );
      }
    });
  }
}
