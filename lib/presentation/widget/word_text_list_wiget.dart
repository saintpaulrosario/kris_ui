import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word_text.dart';

import 'word_text_item_widget.dart';

class WordTextListWidget extends StatelessWidget {
  final List<WordText> texts;

  const WordTextListWidget({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: texts.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          WordText text = texts[index];
          return Text("text sku");
          //return WordTextItemWidget(text: text);
        },
      ),
    );
  }
}
