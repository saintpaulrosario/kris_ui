import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/translation/bloc/translation_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/presentation/screen/word_item_screen.dart';
import 'package:kris/presentation/widget/section_widget.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';

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

    context.read<TranslationBloc>().add(
      BaseEvent.bySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      TranslationBloc,
      BaseState,
      ({bool fetching, Translation? word})
    >(
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

        final examples = [];

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            WordItemScreen(identifier: widget.identifier, maya: ''),

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
                        maya: '',
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
