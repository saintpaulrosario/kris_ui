import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../model/identifier.dart';
import 'word_text_item_widget.dart';

class WordTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;
  final String maya;
  final Set<String> visited;

  const WordTextListWidget({
    super.key,
    required this.identifiers,
    required this.maya,
    required this.visited,
  });

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text("No text found"),
        ),
      );
    }

    return Card(
      child: Column(
        children: List.generate(identifiers.length, (index) {
          final identifier = identifiers[index];

          return Column(
            children: [
              if (index > 0) const Divider(height: 1),
              WordTextItemWidget(
                key: ValueKey('${identifier.sku}_$maya'),
                identifier: identifier,
                maya: maya,
                visited: visited,
              ),
            ],
          );
        }),
      ),
    );
  }
}
