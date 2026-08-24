import 'package:flutter/material.dart';
import 'package:kris/model/definition.dart';

import 'example_text_list_widget.dart';

class ExampleWidget extends StatelessWidget {
  final Definition definition;

  const ExampleWidget({super.key, required this.definition});

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
            child: ExampleTextListWidget(
              key: ValueKey('${definition.sku}-texts'),
              identifiers: definition.texts,
            ),
          ),
        ],
      ),
    );
  }
}
