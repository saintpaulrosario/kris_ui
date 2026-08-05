import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/language_widget.dart';

import '../../model/identifier.dart';
import 'content_item_wiget.dart';

class LanguageListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const LanguageListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: ListTile.divideTiles(
          context: context,
          tiles: identifiers.map(
            (identifier) => LanguageWidget(
              key: ValueKey(identifier.sku),
              identifier: identifier,
            ),
          ),
        ).toList(),
      ),
    );
  }
}
