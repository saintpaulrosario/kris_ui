import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/word_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/word.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/text.dart' as w;

import 'script_widget.dart';

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
    _fetch();
  }

  @override
  void didUpdateWidget(covariant TextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.identifier.sku != widget.identifier.sku) {
      _fetch();
    }
  }

  void _fetch() {
    if (widget.visited.contains(widget.identifier.sku)) {
      return;
    }

    context.read<WordBloc>().add(
      BaseEvent.textBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Don't render a text that is already in the chain.
    if (widget.visited.contains(widget.identifier.sku)) {
      return const SizedBox.shrink();
    }

    return BlocSelector<
      WordBloc,
      BaseState<Word, w.Text, Content, Payload>,
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
          return const SizedBox(
            height: 30,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final text = state.text;

        if (text == null) {
          return const SizedBox.shrink();
        }

        // Mark THIS text as visited.
        final visited = {...widget.visited, text.sku};

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text.sku),

            // Only create the script if the script itself
            // hasn't already appeared in the chain.
            if (!visited.contains(text.script.sku))
              ScriptWidget(
                key: ValueKey(text.script.sku),
                identifier: text.script,
                visited: visited,
              ),
          ],
        );
      },
    );
  }
}
