import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/example_text/bloc/example_text_bloc.dart';
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

    if ('WORD' == widget.identifier.type) {
      context.read<WordTextBloc>().add(
        WordTextEventRetrieveByIdentifier(identifier: widget.identifier),
      );
    } else {
      context.read<ExampleTextBloc>().add(
        ExampleTextEventFetchByIdentifier(identifier: widget.identifier),
      );
    }
  }

  Widget _buildContent(WordText? wordText, bool fetching) {
    if (fetching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (wordText == null) {
      return const Text("Text not found");
    }

    if (wordText.contents.isEmpty) {
      return const Text("No content found");
    }

    return ContentListWidget(
      identifiers: wordText.contents,
      key: Key(wordText.sku),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.identifier.type == 'EXAMPLE') {
      return BlocSelector<
        ExampleTextBloc,
        ExampleTextState,
        ({bool fetching, WordText? wordText})
      >(
        selector: (state) => (
          fetching: state.fetching.contains(widget.identifier.sku),
          wordText: state.data[widget.identifier.sku],
        ),

        builder: (context, state) {
          return _buildContent(state.wordText, state.fetching);
        },
      );
    }

    return BlocSelector<
      WordTextBloc,
      WordTextState,
      ({bool fetching, WordText? wordText})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        wordText: state.data[widget.identifier.sku],
      ),

      builder: (context, state) {
        return _buildContent(state.wordText, state.fetching);
      },
    );
  }
}
