import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'content_item_wiget.dart';

class ContentListWidget extends StatelessWidget {
  final List<Identifier> identifiers;
  final String maya;

  const ContentListWidget({
    super.key,
    required this.identifiers,
    required this.maya,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: ListTile.divideTiles(
          context: context,
          tiles: identifiers.map(
            (identifier) => ContentItemWidget(
              key: ValueKey('${identifier.sku}_$maya'),
              identifier: identifier,
              maya: maya,
            ),
          ),
        ).toList(),
      ),
    );
  }
}
