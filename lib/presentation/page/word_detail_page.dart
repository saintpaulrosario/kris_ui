import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/word/bloc/word_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word.dart';
import 'package:kris/presentation/screen/word_item_screen.dart';

class WordDetailPage extends StatelessWidget {
  final Identifier identifier;

  const WordDetailPage({super.key, required this.identifier});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordBloc, WordState>(
      builder: (context, state) {
        final fetching = state.fetching.contains(identifier.sku);
        final word = state.data[identifier.sku];

        if (fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (word == null) {
          return const Center(child: Text("Word not found"));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            WordItemScreen(identifier: identifier),

            const SizedBox(height: 16),

            Card.filled(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Examples",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 12),

                    if (word.examples.isEmpty)
                      const Text("No examples")
                    else
                      ...word.examples.map(
                        (example) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: WordItemScreen(identifier: example),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
