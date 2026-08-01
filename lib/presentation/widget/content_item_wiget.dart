import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/word_content.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/identifier.dart';
import '../../model/word.dart';
import 'payload_list_widget.dart';

class ContentItemWidget extends StatefulWidget {
  final Identifier identifier;

  const ContentItemWidget({super.key, required this.identifier});

  @override
  State<ContentItemWidget> createState() => _ContentItemWidgetState();
}

class _ContentItemWidgetState extends State<ContentItemWidget> {
  @override
  void initState() {
    super.initState();

    context.read<WordBloc>().add(
      RetrieveWordsEventFetchContentBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      WordBloc,
      WordState,
      ({bool fetching, WordContent? content})
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

        if (state.content == null) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Content not found"),
          );
        }

        if (state.content!.payloads.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No payload found"),
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text("definition", textAlign: TextAlign.center),
              ),
            ),

            Expanded(
              flex: 4,
              child: PayloadListWidget(
                key: ValueKey(state.content!.sku),
                identifiers: state.content!.payloads,
              ),
            ),
          ],
        );
      },
    );
  }
}
