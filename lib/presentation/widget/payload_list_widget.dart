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
      children: identifiers.map((identifier) {
        return Row(
          children: [
            Flexible(
              child: PayloadItemWidget(
                key: ValueKey(identifier.sku),
                identifier: identifier,
              ),
            ),

            const SizedBox(width: 4),

            const Text('sound', overflow: TextOverflow.ellipsis),

            const SizedBox(width: 4),

            const Text('dialect', overflow: TextOverflow.ellipsis),
          ],
        );
      }).toList(),
    );
  }
}
