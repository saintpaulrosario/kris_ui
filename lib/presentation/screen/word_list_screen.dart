import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

import '../screen/word_item_screen.dart';

class WordListScreen extends StatelessWidget {
  final List<Identifier> identifiers;

  const WordListScreen({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: identifiers.length,

        itemBuilder: (context, index) {
          final identifier = identifiers.elementAt(index);

          return WordItemScreen(
            key: ValueKey(identifier.sku),
            identifier: identifier,
          );
        },
      ),
    );
  }
}
