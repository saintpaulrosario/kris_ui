import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'payload_item_widget.dart';

class PayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;
  final String maya;

  const PayloadListWidget({
    super.key,
    required this.identifiers,
    required this.maya,
  });

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Text("No payload found");
    }

    if ({'SCRIPT', 'LANGUAGE', 'DIALECT'}.contains(maya)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: identifiers.map((identifier) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 50),
                  child: PayloadItemWidget(
                    key: ValueKey('${identifier.sku}_$maya'),
                    identifier: identifier,
                    maya: maya,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: identifiers.map((identifier) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 50),
                child: PayloadItemWidget(
                  key: ValueKey('${identifier.sku}_$maya'),
                  identifier: identifier,
                  maya: maya,
                ),
              ),

              const Text('sound'),
              const Text('dialect'),
            ],
          ),
        );
      }).toList(),
    );
  }
}
