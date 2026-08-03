import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'payload_item_widget.dart';
import 'script_payload_widget.dart';

class ScriptPayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const ScriptPayloadListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Text("No payload found");
    }

    return Column(
      children: identifiers.asMap().entries.map((entry) {
        final index = entry.key;
        final identifier = entry.value;

        return Row(
          children: [
            ScriptPayloadWidget(
              key: ValueKey(identifier.sku),
              identifier: identifier,
            ),
          ],
        );
      }).toList(),
    );
  }
}
