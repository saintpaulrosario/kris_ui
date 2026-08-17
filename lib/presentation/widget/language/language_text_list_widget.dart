import 'package:flutter/material.dart';

import '../../../model/identifier.dart';
import 'language_text_widget.dart';

class LanguageTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const LanguageTextListWidget({super.key, required this.identifiers});

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
        return LanguageTextWidget(
          identifier: identifiers[index],
          key: ValueKey(identifiers[index].sku),
        );
      },
    );
  }
}
