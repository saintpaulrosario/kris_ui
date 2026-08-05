import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'script_text_widget.dart';

class ScriptTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const ScriptTextListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    debugPrint("ScriptTextListWidget rebuild ${identifiers.length}");

    if (identifiers.isEmpty) {
      return const Text("No text found");
    }

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: identifiers.length,
        separatorBuilder: (_, index) {
          return const Divider();
        },
        itemBuilder: (_, index) {
          final identifier = identifiers[index];

          return ScriptTextWidget(
            key: ValueKey(identifier.sku),
            identifier: identifier,
          );
        },
      ),
    );
  }
}
