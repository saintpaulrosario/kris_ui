import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'word_text_item_widget.dart';

class WordTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const WordTextListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Text("No text found");
    }

    return Column(
      children: identifiers.map((identifier) {
        return Column(
          children: [
            WordTextItemWidget(identifier: identifier),
            const Divider(height: 1),
          ],
        );
      }).toList(),
    );
  }
}
