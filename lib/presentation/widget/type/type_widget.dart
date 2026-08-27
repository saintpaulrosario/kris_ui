import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/dialect/dialect_text_widget.dart';

import '../../../model/identifier.dart';

class TypeTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const TypeTextListWidget({super.key, required this.identifiers});

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
        return DialectTextWidget(
          identifier: identifiers[index],
          key: ValueKey(identifiers[index].sku),
        );
      },
    );
  }
}
