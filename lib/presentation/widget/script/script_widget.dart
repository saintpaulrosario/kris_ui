import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/script/script_text_list_widget.dart';

import '../../../model/content.dart';
import '../../../model/script.dart';
import 'package:kris/model/text.dart' as w;

class ScriptWidget extends StatefulWidget {
  final Identifier identifier;

  const ScriptWidget({super.key, required this.identifier});

  @override
  State<ScriptWidget> createState() => _ScriptWidgetState();
}

class _ScriptWidgetState extends State<ScriptWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();

    context.read<ScriptBloc>().add(
      BaseEvent.identifier(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload>,
      ({bool fetching, Script? script})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          script: state.data[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.fetching || state.script == null) {
          return const CircularProgressIndicator();
        }

        return ScriptTextListWidget(identifiers: state.script!.texts);
      },
    );
  }
}
