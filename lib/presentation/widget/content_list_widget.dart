import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'content_wiget.dart';

class ContentListWidget extends StatelessWidget {
  final List<Identifier> identifiers;
  final String maya;
  final Set<String> visited;

  const ContentListWidget({
    super.key,
    required this.identifiers,
    required this.maya,
    required this.visited,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: ListTile.divideTiles(
          context: context,
          tiles: identifiers.map(
            (identifier) => ContentWidget(
              key: ValueKey(identifier.sku),
              identifier: identifier,
              maya: maya,
              visited: visited,
            ),
          ),
        ).toList(),
      ),
    );
  }
}
