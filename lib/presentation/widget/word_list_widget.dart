import 'package:flutter/material.dart';

import '../../model/word.dart';
import '../screen/word_item_screen.dart';

class WordListWidget extends StatelessWidget {
  final List<Word> words;

  const WordListWidget({super.key, required this.words});

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
          itemCount: words.length,
          itemBuilder: (context, index) {
            var word = words[index];
            return WordItemScreen(word: word);
          },
        ),
      ),
    );
  }
}
