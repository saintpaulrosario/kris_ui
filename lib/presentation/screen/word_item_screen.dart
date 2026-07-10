import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/widget/word_text_list_wiget.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';
import '../widget/image_list_widget.dart';

class WordItemScreen extends StatefulWidget {
  final Word word;

  const WordItemScreen({super.key, required this.word});

  @override
  State<WordItemScreen> createState() => _WordItemScreenState();
}

class _WordItemScreenState extends State<WordItemScreen> {
  @override
  void initState() {
    super.initState();

    _retrieveIfNeeded();
  }

  @override
  void didUpdateWidget(covariant WordItemScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.word.sku != widget.word.sku) {
      _retrieveIfNeeded();
    }
  }

  void _retrieveIfNeeded() {
    final exists = context.read<WordBloc>().state.data.containsKey(
      widget.word.sku,
    );

    if (!exists) {
      context.read<WordBloc>().add(
        RetrieveWordBySkuEvent(sku: widget.word.sku),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, ({bool fetching, Word? word})>(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.word.sku),
          word: state.data[widget.word.sku],
        );
      },

      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        final word = state.word;

        if (word == null) {
          return const Center(child: Text("Word not found"));
        }

        return Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: ImageListWidget(imagesIdentifiers: word.images)),

              const Expanded(child: Column(children: [Text("definition")])),

              Expanded(
                flex: 3,
                child: WordTextListWidget(identifiers: word.texts),
              ),
            ],
          ),
        );
      },
    );
  }
}
