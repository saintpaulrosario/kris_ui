import 'package:bloc/bloc.dart';
import 'package:kris/logic/example/example.dart';
import 'package:kris/service_locator.dart';

import '../../../model/error_response.dart';
import '../../base_state.dart';
import '../example_service.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final ExampleService _exampleService = getIt<ExampleService>();

  ExampleBloc() : super(ExampleState.initial()) {
    on<ExampleEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ExampleEventFetchBySku>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      fetching.add(event.sku);
      emit(state.copyWith(fetching: fetching));
      await _exampleService.retrieveBySku(event.sku).then((result) {
        result.fold((error) {}, (script) {
          Map<String, Example> data = Map<String, Example>.from(state.data);
          data[event.sku] = script;
          emit(state.copyWith(data: data));
        });
      });
      fetching.remove(event.sku);
      emit(state.copyWith(fetching: fetching));
    });
  }
}
