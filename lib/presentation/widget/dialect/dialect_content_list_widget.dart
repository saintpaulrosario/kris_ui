import 'package:flutter/material.dart';

import '../../../model/identifier.dart';
import 'dialect_content_widget.dart';

class DialectContentListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const DialectContentListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < identifiers.length; i++) ...[
          if (i > 0) const Divider(height: 1),

          DialectContentWidget(
            key: ValueKey(identifiers[i].sku),
            identifier: identifiers[i],
          ),
        ],
      ],
    );
  }
}
