import 'package:flutter/material.dart';
import 'package:kris/model/definition.dart';

import 'definition_text_list_widget.dart';

class DefinitionWidget extends StatelessWidget {
  final Definition definition;

  const DefinitionWidget({super.key, required this.definition});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(definition.sku),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: DefinitionTextListWidget(
              key: ValueKey('${definition.sku}-texts'),
              identifiers: definition.texts,
            ),
          ),
        ],
      ),
    );
  }
}
