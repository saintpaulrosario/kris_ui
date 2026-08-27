import 'package:flutter/material.dart';

import '../../../model/identifier.dart';
import 'type_payload_widget.dart';

class TypePayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const TypePayloadListWidget({super.key, required this.identifiers});

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

        return TypePayloadWidget(
          key: ValueKey(identifier.sku),
          identifier: identifier,
        );
      },
    );
  }
}
