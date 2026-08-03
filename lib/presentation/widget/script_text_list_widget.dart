import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'script_text_widget.dart';
import 'word_text_item_widget.dart';

class ScriptTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const ScriptTextListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Text("No text found");
    }

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: identifiers.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          Identifier identifier = identifiers.elementAt(index);
          return ScriptTextWidget(
            identifier: identifier,
            key: Key(identifier.sku),
          );
        },
      ),
    );
  }
}
