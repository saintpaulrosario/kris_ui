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
    context.read<WordTextBloc>().add(
      WordTextEventRetrieveBySku(sku: widget.identifier.sku),
    );
    super.initState();
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
          return const Center(child: Text("data"));
        }

        final wordText = state.wordText;

        if (wordText == null) {
          context.read<WordTextBloc>().add(
            WordTextEventRetrieveBySku(sku: widget.identifier.sku),
          );
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
