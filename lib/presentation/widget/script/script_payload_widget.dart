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
import 'package:kris/presentation/widget/audio_list_wiget.dart';

class ScriptPayloadWidget extends StatefulWidget {
  final Identifier identifier;

  const ScriptPayloadWidget({super.key, required this.identifier});

  @override
  State<ScriptPayloadWidget> createState() => _ScriptPayloadWidgetState();
}

class _ScriptPayloadWidgetState extends State<ScriptPayloadWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<ScriptBloc>().add(
      BaseEvent.payload(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload, Trait>,
      Payload?
    >(
      selector: (state) {
        return state.payloads[widget.identifier.sku];
      },
      builder: (context, payload) {
        if (payload == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<Identifier> audios = payload.audios.isEmpty
            ? []
            : [payload.audios.first];
        return Row(
          children: [
            Expanded(flex: 1, child: SoundListWidget(identifiers: audios)),
            Expanded(
              flex: 6,
              child: Text(
                payload.value,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ],
        );
      },
    );
  }
}
