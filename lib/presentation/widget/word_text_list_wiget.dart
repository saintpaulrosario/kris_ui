import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'word_text_item_widget.dart';

class WordTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const WordTextListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: identifiers.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        Identifier identifier = identifiers[index];

        return WordTextItemWidget(identifier: identifier);
      },
    );
  }
}
