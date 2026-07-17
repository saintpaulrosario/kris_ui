import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/example/bloc/example_bloc.dart';
import 'package:kris/logic/word/bloc/word_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word.dart';
import 'package:kris/presentation/widget/word_text_list_wiget.dart';

import '../widget/image_list_widget.dart';

class WordItemScreen extends StatefulWidget {
  final Identifier identifier;

  const WordItemScreen({super.key, required this.identifier});

  @override
  State<WordItemScreen> createState() => _WordItemScreenState();
}

class _WordItemScreenState extends State<WordItemScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.identifier.type == 'EXAMPLE') {
      context.read<ExampleBloc>().add(
        ExampleEventFetch(identifier: widget.identifier),
      );
    } else {
      context.read<WordBloc>().add(
        RetrieveWordBySkuEvent(identifier: widget.identifier),
      );
    }
  }

  Widget _buildWord(Word? word, bool fetching) {
    if (fetching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (word == null) {
      return const Center(child: Text("Word not found"));
    }

    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: ImageListWidget(
              key: Key(word.sku),
              imagesIdentifiers: word.images,
            ),
          ),

          const Expanded(
            flex: 5,
            child: Column(children: [Text("definition")]),
          ),

          Expanded(
            flex: 5,
            child: WordTextListWidget(
              identifiers: word.texts,
              key: Key(word.sku),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.identifier.type == 'EXAMPLE') {
      return BlocSelector<
        ExampleBloc,
        ExampleState,
        ({bool fetching, Word? word})
      >(
        selector: (state) => (
          fetching: state.fetching.contains(widget.identifier.sku),
          word: state.data[widget.identifier.sku],
        ),

        builder: (context, state) {
          return _buildWord(state.word, state.fetching);
        },
      );
    }

    return BlocSelector<WordBloc, WordState, ({bool fetching, Word? word})>(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        word: state.data[widget.identifier.sku],
      ),

      builder: (context, state) {
        return _buildWord(state.word, state.fetching);
      },
    );
  }
}
