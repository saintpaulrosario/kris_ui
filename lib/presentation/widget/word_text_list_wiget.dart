import 'package:flutter/material.dart';
import 'package:kris/model/word_text.dart';

import '../../model/identifier.dart';

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
          Identifier text = textsIdentifiers[index];
          return Text("text sku: ${text.sku}");
          //return WordTextItemWidget(text: text);
        },
      ),
    );
  }
}
