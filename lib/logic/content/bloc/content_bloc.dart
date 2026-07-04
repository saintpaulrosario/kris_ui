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
      final fetching = Set<String>.from(state.fetching);
      fetching.add(event.textSku);
      emit(state.copyWith(fetching: fetching));

      final results = await _contentService.retriveByTextIdentifier(
        event.textSku,
      );

      fetching.remove(event.textSku);
      emit(state.copyWith(fetching: fetching));

      results.fold((error) {}, (contents) {});
    });

    on<ContentEventRetriveBySku>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      fetching.add(event.sku);
      emit(state.copyWith(fetching: fetching));

      final Either<ErrorResponse, Content> result = await _contentService
          .retriveBySku(event.sku);

      result.fold((error) {}, (content) {
        final contents = Map<String, Content>.from(state.contents);
        contents[event.sku] = content;
        emit(state.copyWith(contents: contents));
      });
      fetching.remove(event.sku);
      emit(state.copyWith(fetching: fetching));
    });
  }
}
