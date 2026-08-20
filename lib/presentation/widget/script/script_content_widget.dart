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
import 'package:kris/model/trait.dart';

import 'script_payload_widget.dart';

class ScriptContentWidget extends StatefulWidget {
  final Identifier identifier;

  const ScriptContentWidget({super.key, required this.identifier});

  @override
  State<ScriptContentWidget> createState() => _ScriptContentWidgetState();
}

class _ScriptContentWidgetState extends State<ScriptContentWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<ScriptBloc>().add(
      BaseEvent.content(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload, Trait>,
      Content?
    >(
      selector: (state) {
        return state.contents[widget.identifier.sku];
      },
      builder: (context, content) {
        if (content == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (content.payloads.isEmpty) {
          return const Text('No payload');
        }

        final payloadIdentifier = content.payloads.first;

        return ScriptPayloadWidget(
          key: ValueKey('script-payload-${payloadIdentifier.sku}'),
          identifier: payloadIdentifier,
        );
      },
    );
  }
}
