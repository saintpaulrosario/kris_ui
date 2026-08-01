import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/response/error_response.dart';

import '../../../model/script.dart';
import '../../../model/script_content.dart';
import '../../../model/script_payload.dart';
import '../../../model/script_text.dart';
import '../../../response/page_result.dart';
import '../../base_state.dart';

part 'script_event.dart';
part 'script_state.dart';

class ScriptBloc extends Bloc<ScriptEvent, ScriptState> {
  ScriptBloc() : super(ScriptState.initial()) {
    on<ScriptEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
