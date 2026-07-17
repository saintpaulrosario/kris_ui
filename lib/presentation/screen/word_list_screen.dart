import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

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
      key: Key(identifiers[0].type),
      children: [
        for (final identifier in identifiers)
          WordItemScreen(key: ValueKey(identifier.sku), identifier: identifier),
      ],
    );
  }
}
