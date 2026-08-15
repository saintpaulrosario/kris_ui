import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';

import '../../../logic/base_event.dart';
import '../../../logic/base_state.dart';
import '../../../model/content.dart';
import '../../../model/identifier.dart';
import 'package:kris/model/text.dart' as w;

class ScriptPayloadWidget extends StatefulWidget {
  final Identifier identifier;

  const ScriptPayloadWidget({super.key, required this.identifier});

  @override
  State<ScriptPayloadWidget> createState() => _ScriptPayloadWidgetState();
}

class _ScriptPayloadWidgetState extends State<ScriptPayloadWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<ScriptBloc>().add(
      BaseEvent.payloadBySku(identifier: widget.identifier, dialects: {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocSelector<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload>,
      ({bool fetching, Payload? payload})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        payload: state.payloads[widget.identifier.sku],
      ),

      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.payload == null) {
          return const Text("Payload was not fetched");
        }

        return Text(
          state.payload!.value,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          key: ValueKey(state.payload!.sku),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
