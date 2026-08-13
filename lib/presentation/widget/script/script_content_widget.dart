import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/script/script_payload_list_widget.dart';

class ScriptContentWidget extends StatefulWidget {
  final Identifier identifier;
  const ScriptContentWidget({super.key, required this.identifier});

  @override
  State<ScriptContentWidget> createState() => _ScriptContentWidgetState();
}

class _ScriptContentWidgetState extends State<ScriptContentWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ScriptBloc>().add(
      BaseEvent.contentBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ScriptBloc,
      BaseState,
      ({bool fetching, Content? content})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          content: state.texts[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.fetching) {
          return CircularProgressIndicator();
        }

        return ScriptPayloadListWidget(identifiers: state.content!.payloads);
      },
    );
  }
}
