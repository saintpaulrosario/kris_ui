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

import 'script_text_list_widget.dart';

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
      Script?
    >(
      selector: (state) {
        return state.data[widget.identifier.sku];
      },
      builder: (context, script) {
        if (script == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return ScriptTextListWidget(
          key: ValueKey('script-text-list-${script.sku}'),
          identifiers: script.texts,
        );
      },
    );
  }
}
