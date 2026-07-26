import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/word/bloc/word_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/logic/word/word.dart';
import 'package:kris/presentation/screen/word_item_screen.dart';
import 'package:kris/presentation/widget/section_widget.dart';

class WordDetailPage extends StatefulWidget {
  final Identifier identifier;

  const WordDetailPage({super.key, required this.identifier});

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  @override
  void initState() {
    super.initState();

    context.read<WordBloc>().add(
      RetrieveWordBySkuEvent(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, ({bool fetching, Word? word})>(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        word: state.data[widget.identifier.sku],
      ),
      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        final word = state.word;

        if (word == null) {
          return const Center(child: Text("Word not found"));
        }

        final examples = word.examples;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            WordItemScreen(identifier: widget.identifier),

            if (examples.isNotEmpty) ...[
              const SizedBox(height: 16),

              SectionWidget(
                title: "EXAMPLES",
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: examples.length,
                  itemBuilder: (context, index) {
                    final identifier = examples[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: WordItemScreen(
                        key: ValueKey(identifier.sku),
                        identifier: identifier,
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
