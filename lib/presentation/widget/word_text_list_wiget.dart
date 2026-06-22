import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

import '../../model/word.dart';
import '../screen/word_item_screen.dart';
import 'word_text_item_widget.dart';

class WordTextListWidget extends StatelessWidget {
  final List<Identifier> texts;

  const WordTextListWidget({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.red,
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          clipBehavior: Clip.hardEdge,
          separatorBuilder: (context, index) {
            return const Divider(height: 1.0);
          },
          itemCount: texts.length,
          itemBuilder: (context, index) {
            var text = texts[index];
            return Card(child: WordTextItemWidget(textIdentifier: text));
          },
        ),
      ),
    );
  }
}
