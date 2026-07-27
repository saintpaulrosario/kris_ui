import 'package:flutter/material.dart';

import '../../logic/identifier.dart';
import '../screen/word_item_screen.dart';

class WordListScreen extends StatelessWidget {
  final List<Identifier> identifiers;

  const WordListScreen({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Text("No words found");
    }

    return Column(
      children: List.generate(identifiers.length, (index) {
        final identifier = identifiers[index];

        return WordItemScreen(
          key: ValueKey('${identifier.sku}-$index'),
          identifier: identifier,
        );
      }),
    );
  }
}
