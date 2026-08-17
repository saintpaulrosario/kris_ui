import 'package:flutter/material.dart';

import '../../../model/identifier.dart';
import 'language_payload_widget.dart';

class LanguagePayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const LanguagePayloadListWidget({super.key, required this.identifiers});

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

        return LanguagePayloadWidget(
          key: ValueKey(identifier.sku),
          identifier: identifier,
        );
      },
    );
  }
}
