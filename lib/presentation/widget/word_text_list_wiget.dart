import 'package:flutter/material.dart';
import 'package:kris/model/word_text.dart';

import '../../model/identifier.dart';
import 'word_text_item_widget.dart';

class WordTextListWidget extends StatelessWidget {
  final List<WordText> wordTexts;

  const WordTextListWidget({super.key, required this.wordTexts});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: wordTexts.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          Identifier identifier = wordTexts[index];
          return WordTextItemWidget(identifier: identifier);
        },
      ),
    );
  }
}
