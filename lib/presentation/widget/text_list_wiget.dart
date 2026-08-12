import 'package:flutter/material.dart';
import 'package:kris/model/text.dart' as m;

class TextListCell extends StatelessWidget {
  final List<m.Text> texts;

  const TextListCell({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int index = 0; index < texts.length; index++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              texts[index].sku,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}
