import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/word_bloc.dart';
import 'package:kris/model/identifier.dart';

import 'script_widget.dart';
import 'package:kris/model/text.dart' as w;

class TextWidget extends StatefulWidget {
  final Identifier identifier;
  final Set<String> visited;

  const TextWidget({
    super.key,
    required this.identifier,
    required this.visited,
  });

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  void initState() {
    super.initState();

    context.read<WordBloc>().add(
      BaseEvent.textBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, BaseState, ({bool fetching, w.Text? text})>(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          text: state.texts[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.fetching) {
          return const CircularProgressIndicator();
        }

        final text = state.text;

        if (text == null) {
          return const CircularProgressIndicator();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Always show text
            Text(text.sku),

            // Only show script if it hasn't been visited
            if (!widget.visited.contains(text.script.sku))
              ScriptWidget(
                identifier: text.script,
                visited: {...widget.visited, widget.identifier.sku},
              ),
          ],
        );
      },
    );
  }
}
