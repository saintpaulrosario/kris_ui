import 'package:flutter/material.dart';

import '../../logic/identifier.dart';
import 'word_text_item_widget.dart';

class WordTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const WordTextListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Text("No text found");
    }

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: identifiers.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          Identifier identifier = identifiers.elementAt(index);
          return WordTextItemWidget(
            identifier: identifier,
            key: Key(identifier.sku),
          );
        },
      ),
    );
  }
}
