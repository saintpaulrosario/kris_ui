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
    // Prevent circular text references.
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
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final text = state.text;

        if (text == null) {
          return const SizedBox.shrink();
        }

        // Mark this text as visited.
        final visited = {...widget.visited, text.sku};

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(text.sku, softWrap: true),
              ),
            ),

            Expanded(
              child: visited.contains(text.script.sku)
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(8),
                      child: ScriptWidget(
                        key: ValueKey(text.script.sku),
                        identifier: text.script,
                        visited: visited,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
