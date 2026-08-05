import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/script_content.dart';
import 'package:kris/model/translation_content.dart';

import '../../logic/base_event.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/identifier.dart';
import 'payload_list_widget.dart';
import 'script_payload_list_widget.dart';

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
      ScriptState,
      ({bool fetching, ScriptContent? content})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        content: state.contents[widget.identifier.sku],
      ),

      builder: (context, state) {
        if (state.fetching) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.content == null) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Content not found"),
          );
        }

        if (state.content!.payloads.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No payload found"),
          );
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ScriptPayloadListWidget(
              key: ValueKey(state.content!.sku),
              identifiers: state.content!.payloads,
            ),
          ],
        );
      },
    );
  }
}
