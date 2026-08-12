import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/text_widget.dart';

import '../../model/content.dart';
import '../../model/script.dart';
import 'package:kris/model/text.dart' as w;

class ScriptWidget extends StatefulWidget {
  final Identifier identifier;
  final Set<String> visited;
  const ScriptWidget({
    super.key,
    required this.identifier,
    required this.visited,
  });

  @override
  State<ScriptWidget> createState() => _ScriptWidgetState();
}

class _ScriptWidgetState extends State<ScriptWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ScriptBloc>().add(
      BaseEvent.bySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.visited.contains(widget.identifier.sku)) {
      return SizedBox.shrink();
    }
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
        return TextWidget(
          identifier: widget.identifier,
          visited: {...widget.visited, widget.identifier.sku},
        );
      },
    );
  }
}
