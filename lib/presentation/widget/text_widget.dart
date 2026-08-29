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
      child: Row(
        children: [
          Flexible(
            flex: 10,
            child: ContentListWidget(identifiers: text.contents),
          ),
          Flexible(
            flex: 1,
            child: ScriptWidget(
              key: ValueKey(text.script.sku),
              identifier: text.script,
            ),
          ),
        ],
      ),
    );
  }
}
