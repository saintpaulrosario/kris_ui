import 'package:flutter/material.dart';

import 'package:kris/model/text.dart' as w;

import 'example_content_list_widget.dart';

class ExampleTextWidget extends StatelessWidget {
  final w.Text text;

  const ExampleTextWidget({super.key, required this.text});

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
              flex: 6,
              child: ExampleContentListWidget(identifiers: text.contents),
            ),
          ],
        ),
      ),
    );
  }
}
