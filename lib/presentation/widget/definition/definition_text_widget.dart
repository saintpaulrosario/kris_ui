import 'package:flutter/material.dart';

import 'package:kris/model/text.dart' as w;

import 'definition_content_list_widget.dart';

class DefinitionTextWidget extends StatelessWidget {
  final w.Text text;

  const DefinitionTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: DefinitionContentListWidget(identifiers: text.contents),
            ),
          ],
        ),
      ),
    );
  }
}
