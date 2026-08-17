import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/dialect/dialect_text_widget.dart';

import '../../../model/identifier.dart';

class DialectTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const DialectTextListWidget({super.key, required this.identifiers});

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

        return DialectTextWidget(
          key: ValueKey(identifier.sku),
          identifier: identifier,
        );
      },
    );
  }
}
