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
      children: [
        for (final identifier in identifiers) ...[
          PayloadItemWidget(identifier: identifier, key: Key(identifier.sku)),
        ],
      ],
    );
  }
}
