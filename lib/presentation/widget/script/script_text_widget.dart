import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';
import 'package:kris/model/text.dart' as w;
import 'package:kris/presentation/widget/script/script_content_list_widget.dart';

class ScriptTextWidget extends StatefulWidget {
  final Identifier identifier;
  const ScriptTextWidget({super.key, required this.identifier});

  @override
  State<ScriptTextWidget> createState() => _ScriptTextWidgetState();
}

class _ScriptTextWidgetState extends State<ScriptTextWidget> {
  @override
  void initState() {
    super.initState();

    Set<String> scripts = context.watch<ScriptBloc>().state.selections.toSet();

    context.read<ScriptBloc>().add(
      BaseEvent.textBySku(identifier: widget.identifier, scripts: scripts),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload>,
      ({bool fetching, w.Text? text})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          text: state.texts[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.fetching) {
          return CircularProgressIndicator();
        }
        if (state.text == null) {
          return Text("no script");
        }
        return ScriptContentListWidget(identifiers: state.text!.contents);
      },
    );
  }
}
