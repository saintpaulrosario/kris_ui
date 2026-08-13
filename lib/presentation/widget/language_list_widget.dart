import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/language_widget.dart';

import '../../model/identifier.dart';

class LanguageListWidget extends StatelessWidget {
  final List<Identifier> identifiers;
  final Set<String> visited;

  const LanguageListWidget({
    super.key,
    required this.identifiers,
    required this.visited,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (_, __) => Divider(),
          itemCount: identifiers.length,
          itemBuilder: (_, index) {
            final identifier = identifiers.elementAt(index);
            return visited.contains(identifier.sku)
                ? SizedBox.shrink()
                : LanguageWidget(identifier: identifier, visited: visited);
          },
        ),
      ],
    );
  }
}
