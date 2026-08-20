import 'package:flutter/material.dart';
import 'package:kris/model/word.dart';

import 'image_list_widget.dart';
import 'text_list_wiget.dart';

class WordWidget extends StatelessWidget {
  final Word word;

  const WordWidget({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(word.sku),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: ImageListWidget(
              key: ValueKey('${word.sku}-images'),
              identifiers: word.images,
            ),
          ),
          Expanded(
            flex: 7,
            child: TextListWidget(
              key: ValueKey('${word.sku}-texts'),
              identifiers: word.texts,
            ),
          ),
        ],
      ),
    );
  }
}
