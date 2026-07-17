import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'payload_item_widget.dart';

class PayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const PayloadListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Text("No payload found");
    }

    return Column(
      children: identifiers.asMap().entries.map((entry) {
        final index = entry.key;
        final identifier = entry.value;

        return Column(
          children: [
            PayloadItemWidget(
              key: ValueKey(identifier.sku),
              identifier: identifier,
            ),

            if (index != identifiers.length - 1) const Divider(height: 1),
          ],
        );
      }).toList(),
    );
  }
}
