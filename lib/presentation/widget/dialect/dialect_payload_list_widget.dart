import 'package:flutter/material.dart';

import '../../../model/identifier.dart';
import 'dialect_payload_widget.dart';

class DialectPayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const DialectPayloadListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: identifiers.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final identifier = identifiers[index];

        return DialectPayloadWidget(
          key: ValueKey(identifier.sku),
          identifier: identifier,
        );
      },
    );
  }
}
