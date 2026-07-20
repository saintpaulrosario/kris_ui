import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/word/bloc/word_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word.dart';
import 'package:kris/presentation/screen/word_item_screen.dart';
import 'package:kris/presentation/widget/example_item_widget.dart';

class WordDetailPage extends StatefulWidget {
  final Identifier identifier;

  const WordDetailPage({super.key, required this.identifier});

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  @override
  void initState() {
    context.read<WordBloc>().add(
      RetrieveWordBySkuEvent(identifier: widget.identifier),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, ({bool fetching, Word? word})>(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          word: state.data[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.word == null) {
          return const Center(child: Text("Word not found"));
        }
        final examples = state.word!.examples;
        return Column(
          children: [
            WordItemScreen(identifier: widget.identifier),

            Expanded(
              child: ListView.builder(
                itemCount: examples.length,
                itemBuilder: (context, index) {
                  final identifier = examples[index];

                  return WordItemScreen(
                    key: ValueKey('${identifier.sku}-$index'),
                    identifier: identifier,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
