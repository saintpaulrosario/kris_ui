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

import 'script_content_list_widget.dart';

class ScriptTextWidget extends StatefulWidget {
  final Identifier identifier;

  const ScriptTextWidget({super.key, required this.identifier});

  @override
  State<ScriptTextWidget> createState() => _ScriptTextWidgetState();
}

class _ScriptTextWidgetState extends State<ScriptTextWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<ScriptBloc>().add(
      BaseEvent.text(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload, Trait>,
      w.Text?
    >(
      selector: (state) {
        return state.texts[widget.identifier.sku];
      },
      builder: (context, text) {
        if (text == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return ScriptContentListWidget(
          key: ValueKey('script-content-list-${text.sku}'),
          identifiers: text.contents,
        );
      },
    );
  }
}
