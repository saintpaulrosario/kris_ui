import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/payload.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../model/identifier.dart';
import '../../model/translation.dart';
import 'package:kris/model/text.dart' as w;

import 'language_list_widget.dart';
import 'payload_list_widget.dart';

class ContentWidget extends StatefulWidget {
  final Identifier identifier;
  final Set<String> visited;

  const ContentWidget({
    super.key,
    required this.identifier,
    required this.visited,
  });

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  @override
  void initState() {
    super.initState();
    if (!widget.visited.contains(widget.identifier.sku)) {
      context.read<TranslationBloc>().add(
        BaseEvent.contentBySku(identifier: widget.identifier),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Stop recursive cycles.
    if (widget.visited.contains(widget.identifier.sku)) {
      return const SizedBox.shrink();
    }

    return BlocSelector<
      TranslationBloc,
      BaseState<Translation, w.Text, Content, Payload>,
      ({bool fetching, Content? content})
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

        final content = state.content;

        if (content == null) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Content not found'),
          );
        }

        if (content.payloads.isEmpty) {
          return const Text('No payload found');
        }

        //final visited = {...widget.visited, text.sku};
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:
                  widget.visited.contains('${widget.identifier.sku}_payloads')
                  ? SizedBox.shrink()
                  : PayloadListWidget(
                      key: ValueKey(content.sku),
                      identifiers: content.payloads,
                      visited: {
                        ...widget.visited,
                        widget.identifier.sku,
                        '${widget.identifier.sku}_payloads',
                      },
                    ),
            ),

            widget.visited.contains('${widget.identifier.sku}_languages')
                ? SizedBox.shrink()
                : Expanded(child: Text('languages')),
            // Expanded(
            //   child: LanguageListWidget(
            //     key: ValueKey('${content.sku}-languages'),
            //     identifiers: content.languages,
            //     visited: widget.visited,
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
