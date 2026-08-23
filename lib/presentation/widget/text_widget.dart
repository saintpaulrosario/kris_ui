import 'package:flutter/material.dart';

import 'package:kris/model/text.dart' as w;
import 'package:kris/presentation/widget/content_list_widget.dart';

import 'script/script_widget.dart';

class TextWidget extends StatelessWidget {
  final w.Text text;

  const TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 12,
              child: ContentListWidget(identifiers: text.contents),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ScriptWidget(
                  key: ValueKey(text.script.sku),
                  identifier: text.script,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
