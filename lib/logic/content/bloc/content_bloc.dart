import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../model/content.dart';
import '../../../model/error_response.dart';
import '../../../model/identifier.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../../payload/bloc/payload_bloc.dart';
import '../content_service.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final _contentService = getIt.get<ContentService>();
  final _payloadBloc = getIt.get<PayloadBloc>();
  ContentBloc() : super(ContentState.initial()) {
    on<ContentEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ContentEventRetriveBySku>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      fetching.add(event.sku);
      emit(state.copyWith(fetching: fetching));

      final Either<ErrorResponse, Content> result = await _contentService
          .retriveBySku(event.sku);

      result.fold(
        (error) {
          fetching.remove(event.sku);
          emit(state.copyWith(fetching: fetching));
        },
        (result) {
          final data = Map<String, Content>.from(state.data);
          data[event.sku] = result;
          fetching.remove(event.sku);
          emit(state.copyWith(data: data, fetching: fetching));
        },
      );
    });

    on<ContentEventAdd>((event, emit) {
      List<Identifier> identifiers = event.identifiers;

      for (Identifier identifier in identifiers) {
        add(ContentEventRetriveBySku(identifier.sku));
      }
    });
  }
}
