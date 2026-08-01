import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/word/bloc/word_bloc.dart';
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
    context.read<WordBloc>().add(
      RetrieveWordsEventFetchTextBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, ({bool fetching, WordText? text})>(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        text: state.texts[widget.identifier.sku],
      ),

      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.text == null) {
          return const Text("Text not found");
        }

        if (state.text!.contents.isEmpty) {
          return const Text("No content found");
        }

        return ContentListWidget(
          identifiers: state.text!.contents,
          key: Key(state.text!.sku),
        );
      },
    );
  }
}
