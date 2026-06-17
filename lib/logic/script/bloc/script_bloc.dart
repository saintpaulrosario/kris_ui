import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'script_event.dart';
part 'script_state.dart';

class ScriptBloc extends Bloc<ScriptEvent, ScriptState> {
  ScriptBloc() : super(ScriptInitial()) {
    on<ScriptEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
