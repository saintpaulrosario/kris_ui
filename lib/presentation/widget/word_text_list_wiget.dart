import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

import 'word_text_item_widget.dart';

class WordTextListWidget extends StatelessWidget {
  final List<Identifier> textsIdentifiers;

  const WordTextListWidget({super.key, required this.textsIdentifiers});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: textsIdentifiers.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return WordTextItemWidget(textIdentifier: textsIdentifiers[index]);
        },
      ),
    );
  }
}
