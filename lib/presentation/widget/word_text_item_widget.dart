import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/text/bloc/word_text_bloc.dart';
import '../../model/identifier.dart';
import '../../model/word_text.dart';
import 'content_list_widget.dart';

class WordTextItemWidget extends StatefulWidget {
  final Identifier identifier;

  const WordTextItemWidget({super.key, required this.identifier});

  @override
  State<WordTextItemWidget> createState() => _WordTextItemWidgetState();
}

class _WordTextItemWidgetState extends State<WordTextItemWidget> {
  @override
  void initState() {
    super.initState();

    _retrieveWordText();
  }

  @override
  void didUpdateWidget(covariant WordTextItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.identifier.sku != widget.identifier.sku) {
      _retrieveWordText();
    }
  }

  void _retrieveWordText() {
    final exists = context.read<WordTextBloc>().state.data.containsKey(
      widget.identifier.sku,
    );

    if (!exists) {
      context.read<WordTextBloc>().add(
        WordTextEventRetrieveBySku(sku: widget.identifier.sku),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      WordTextBloc,
      WordTextState,
      ({bool fetching, WordText? wordText})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          wordText: state.data[widget.identifier.sku],
        );
      },

      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        final wordText = state.wordText;

        if (wordText == null) {
          return const Text("Text not found");
        }

        if (wordText.contents.isEmpty) {
          return const Text("No content found");
        }

        return ContentListWidget(identifiers: wordText.contents);
      },
    );
  }
}
